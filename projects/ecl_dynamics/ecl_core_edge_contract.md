# ECL-Core vs ECL-Edge Responsibilities and Boundary Contract

## ECL-Core Responsibilities
- Provide tiered cognitive modes (T1/T2/T3)
- Preserve semantic intent across structural changes
- Govern AI collaboration and EnaC behavior
- Maintain system invariants (OS-1, DOD-1, Rule 0)
- Ensure orchestration logic and self-alignment

## ECL-Edge Responsibilities
- Map ECL-Core intent to domain-specific APIs
- Handle versioned external systems
- Contain domain rules without polluting core
- Serve as replaceable adapters for UI, API, workflow

## Boundary Contract
- ECL-Core never depends on domain specifics.
- ECL-Edge must respect cognitive intent from Core.
- All external integrations pass through Edge adapters.
- Core evolution must not break Edge contracts; Edge absorbs changes.
