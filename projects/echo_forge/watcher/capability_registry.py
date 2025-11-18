"""Utilities for loading and querying the EchoForge capability registry."""

from __future__ import annotations

from pathlib import Path
from typing import Any, Dict, List, Optional

import yaml

Registry = Dict[str, Any]
Capability = Dict[str, Any]


def load_registry(path: Path) -> Registry:
    """Load the YAML capability registry. Returns empty dict if file missing."""
    if not path.exists():
        return {}
    data = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
    caps = data.get("capabilities", [])
    # Normalize keys for easier filtering
    for cap in caps:
        cap.setdefault("domain", "unknown")
        cap.setdefault("tier_ready", "T1")
    data["capabilities"] = caps
    return data


def select_capability(
    registry: Registry,
    domain: str,
    *,
    policy: str = "auto",
    max_cost: int = 5,
    max_latency: int = 5,
    require_offline: bool = False,
    preferred_privacy: Optional[str] = None,
) -> Optional[Capability]:
    """Pick the best capability for a domain based on policy and constraints."""

    caps: List[Capability] = [
        c for c in registry.get("capabilities", []) if c.get("domain") == domain
    ]

    def allowed(cap: Capability) -> bool:
        if cap.get("cost", 5) > max_cost:
            return False
        if cap.get("latency", 5) > max_latency:
            return False
        offline = cap.get("offline_support", "none")
        if require_offline and offline != "full":
            return False
        if preferred_privacy and cap.get("privacy_mode") != preferred_privacy:
            return False
        return True

    candidates = [c for c in caps if allowed(c)]
    if not candidates:
        return None

    def sort_key(cap: Capability):
        privacy = cap.get("privacy_mode")
        privacy_rank = 0
        if policy == "local-first":
            privacy_order = ["local", "hybrid", "cloud"]
            privacy_rank = (
                privacy_order.index(privacy)
                if privacy in privacy_order
                else len(privacy_order)
            )
        elif policy == "cloud-first":
            privacy_order = ["cloud", "hybrid", "local"]
            privacy_rank = (
                privacy_order.index(privacy)
                if privacy in privacy_order
                else len(privacy_order)
            )
        return (
            privacy_rank,
            cap.get("latency", 5),
            cap.get("cost", 5),
            {"T3": 0, "T2": 1, "T1": 2}.get(cap.get("tier_ready"), 3),
        )

    candidates.sort(key=sort_key)
    return candidates[0]
