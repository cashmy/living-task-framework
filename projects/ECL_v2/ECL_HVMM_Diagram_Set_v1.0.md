# ECL-HVMM Diagram Set v1.0

## 1. Vertical ECL Model

``` mermaid
flowchart TB
  SKY["ECL-SKY"]
  CORE["ECL-CORE"]
  BASE["ECL-BASE"]

  SKY <--> CORE <--> BASE
```

## 2. Horizontal T-State Transitions

``` mermaid
flowchart LR
  T3["T3"]
  T2["T2"]
  T1["T1"]
  T0["T0.5"]

  T3 <--> T2 <--> T1 <--> T0
```

## 3. HVMM Grid

``` mermaid
graph TD

subgraph SKY["ECL-SKY"]
  SKY_T3["SKY-T3"]
  SKY_T2["SKY-T2"]
  SKY_T1["SKY-T1"]
  SKY_T0["SKY-T0.5"]
end

subgraph CORE["ECL-CORE"]
  CORE_T3["CORE-T3"]
  CORE_T2["CORE-T2"]
  CORE_T1["CORE-T1"]
  CORE_T0["CORE-T0.5"]
end

subgraph BASE["ECL-BASE"]
  BASE_T3["BASE-T3"]
  BASE_T2["BASE-T2"]
  BASE_T1["BASE-T1"]
  BASE_T0["BASE-T0.5"]
end

SKY_T3 <--> CORE_T3 <--> BASE_T3
SKY_T2 <--> CORE_T2 <--> BASE_T2
SKY_T1 <--> CORE_T1 <--> BASE_T1
SKY_T0 <--> CORE_T0 <--> BASE_T0
```

## 4. HVMM Flow During Execution

``` mermaid
flowchart LR
  Concept["T3 Design"] 
  Arch["T2 Architecture"] 
  Tasks["T1 Breakdown"] 
  Utils["T0.5 Utilities"] 
  Impl["ECL-BASE Implementation"] 
  Review["ECL-CORE Review"] 
  Purpose["ECL-SKY Realignment"]

  Concept --> Arch --> Tasks --> Utils --> Impl --> Review --> Purpose --> Concept
```
