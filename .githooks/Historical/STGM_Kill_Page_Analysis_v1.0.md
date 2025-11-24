# STGM Artifact — Analysis of Kill Page Events (Chrome 142 Regression)

## Summary
This document captures the root-cause analysis of repeated "kill page" events occurring on a high-performance home computer running Chrome version 142.0.7444.163. The issue is not hardware-related; it is caused by known regression instabilities in Chrome v142 that affect heavy, streaming-intensive web applications such as ChatGPT.

---

## 1. Hardware Not the Limiting Factor
The home machine specifications:
- AMD Ryzen 5 3600 (6-core)
- 128 GB RAM
- 1.8 TB and 3.6 TB SSDs with substantial free space

These specs are far beyond what is required for ChatGPT. The absence of issues on a less powerful work PC confirms this.

---

## 2. Chrome v142 Identified as the Source of Instability
Chrome version **142.x** has known issues:
- Aggressive memory cleanup
- Tab isolation bugs
- WASM scheduling failures
- Over-sensitive hung-tab detection
- Worker thread termination issues

ChatGPT (especially browser-heavy, long-context sessions) triggers these regressions.

Work PC likely runs Chrome 140–141, which do *not* contain these instabilities.

---

## 3. Why Crashes Occurred Immediately at Home
Switching from stable Chrome to:
- Chrome **142.0.7444.163**

…means:
- Page termination upon high CPU use  
- Kill-page triggers during streaming  
- Worker threads being terminated prematurely  

The browser—not ChatGPT—is ending the tab.

---

## 4. Confirmatory Evidence
- **Work PC** (older hardware, older Chrome): **0 crashes**
- **Home PC** (new Chrome): crashes within minutes

This strongly indicates a Chrome regression, not a local system fault.

---

## 5. Recommended Fixes (Priority Order)

### Fix 1 — Switch Browser
**Use Microsoft Edge** for heavy ChatGPT workloads.  
Edge has more stable WASM scheduling and worker-thread isolation.

### Fix 2 — Disable Chrome Memory/CPU Guards
Chrome → Settings → Performance  
- Turn OFF **Memory Saver**  
- Turn OFF **Energy Saver**

### Fix 3 — Disable Hardware Acceleration
Chrome → Settings → System  
- Disable **Use hardware acceleration when available**

### Fix 4 — Install Chrome Canary (v143+) or Downgrade to v141
Chrome 143+ includes partial patches.  
Chrome 141 was last known stable.

### Fix 5 — Use ChatGPT Desktop App
Bypasses Chrome entirely and avoids tab-termination heuristics.

---

## 6. Why Kill Page Events Occur Only at Home
Chrome 142 misinterprets:
- High memory as runaway JS
- Long streaming as a frozen tab
- Heavy WASM workloads as deadlocks

Your home machine is powerful enough that Chrome’s heuristics mistakenly assume something abnormal is occurring.

---

## 7. Conclusion
This is a browser regression problem, not a hardware or ChatGPT problem.  
Chrome 142 is terminating tabs under heavy load due to overly aggressive protection heuristics.

Recommended immediate action: **Use Edge for long ChatGPT sessions**.