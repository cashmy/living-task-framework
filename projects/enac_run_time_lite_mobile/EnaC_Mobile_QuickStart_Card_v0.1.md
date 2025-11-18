# 📱 EnaC Mobile Quick-Start Card (v0.1)
**One-screen cheat sheet for mobile workflows**  
**Author:** Cash Myers + EnaC/CFP Alignment Layer  
**Purpose:** Fast activation + task execution with minimal typing.  
**Compatibility:** EnaC Runtime Lite v0.2 · CTS v0.1 · STMG Micro-Loader v0.1

---

# 🔵 1. Startup (Activation)
Use one of these:

### **Minimal EnaC Activation (recommended)**
```
@A1
```

### **Activation + Hard Sync**
```
@A2
```

---

# 🟣 2. Load a Module (STMG Micro-Loader)

### **Resume Selector**
```
@L1
```

### **ATC Mini (EchoForge Precursor)**
```
@L2
```

### **GlossRP / SCS Kernel Lite**
```
@L3
```

---

# 🟢 3. Execute a Selector Pipeline

### **Full Resume Match + Desirability**
```
@S1
```

### **Job-Only Evaluation**
```
@S2
```

### **Full Cascaded Decision Engine**
```
@S3
```

---

# 🟠 4. Drift / Reset Commands

### **Micro Drift Correction**
```
@D1
```

### **Soft Reset (retain EnaC, clear tasks)**
```
@D2
```

### **Hard Purge + Re-anchor**
```
@D3
```

---

# 🟡 5. Common Mobile Workflows

### **Resume Evaluation — Full Startup**
```
@A1 @L1 @S1
```

### **ATC / EchoForge Idea Capture**
```
@A1 @L2
```

### **Hard Reset + Resume Re-Eval**
```
@D2 @L1 @S1
```

---

# 🔻 6. Module Management (Optional)
```
STMG.Load("<Module>","<Version>")
STMG.Unload("<Module>")
STMG.Switch("<Module>","<Version>")
STMG.List()
```

---

# 🔷 7. Task Switching
```
Switch Task: <TaskName>
```

Examples:
```
Switch Task: Resume Evaluation
Switch Task: Coding Session
Switch Task: ATC Idea Capture
```

---

# 🔳 8. When Things Get Weird
Use one of these:

**Light fix:**
```
@D1
```

**Full fix (recommended):**
```
@D2
```

**Nuke the session, keep EnaC:**
```
@D3
```

---

# 📌 9. Token Legend
- **A-series:** Activation  
- **L-series:** Module Loading  
- **S-series:** Selector Execution  
- **D-series:** Drift / Reset  

---

# End of File
