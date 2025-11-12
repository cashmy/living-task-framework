# Project-Specific CIP: EHR Consent Platform
**Mnemonic**: EHR  
**Status**: Active Development  
**Last Updated**: 2025-11-12

---

## PROJECT IDENTITY

### Basic Information
- **Project Name**: EHR Consent Platform (HIPAA-Compliant Blockchain Consent Management)
- **Mnemonic**: EHR
- **Status**: Active Development
- **Start Date**: 2025-Q3 (estimated based on file structure)
- **Last Active**: 2025-11-12

### Quick Context
HIPAA-compliant patient consent management platform using blockchain (Ethereum/Hardhat) for immutable audit trails, with provider identity verification, hospital registry, and multi-service architecture (auth, consent indexing, EHR gateway, audit pipeline).

---

## CORE CONCEPT

### Problem Statement
**User Pain Point**: 
Healthcare consent management is fragmented (paper forms, siloed databases, no audit trail), consent revocation is difficult, patients lack visibility into who accessed their data, providers have no trustless verification of consent validity.

**Who Experiences This**: 
- **Patients**: No control over consent, can't revoke easily, no visibility into access
- **Providers**: Legal liability if consent invalid, no way to verify across systems
- **Hospitals**: Compliance burden (HIPAA audit trails), manual consent tracking costly

**Gap**: 
No system combines: Blockchain immutability + HIPAA compliance + Patient self-sovereignty + Provider verification + Cross-hospital interoperability

### Vision & Inspiration
**Vision**: 
Patients own consent (self-sovereign identity), providers verify cryptographically (trustless), hospitals share consent state (interoperable), all access logged immutably (HIPAA compliance), consent revocable instantly (patient control).

**Inspiration**:
- Blockchain: Immutability, trustless verification
- Self-sovereign identity: Patient owns keys, not hospital
- Epic/Cerner: EHR systems (but no consent blockchain)
- **EHR Platform adds**: Blockchain + Patient sovereignty + Cross-hospital consent sharing

---

## DOMAIN CONTEXT

### Technologies & Stack
**Languages**: Solidity (smart contracts), TypeScript (services), JavaScript (frontends), Python (py-sdk)  
**Frameworks**: 
- Hardhat (Ethereum development)
- Next.js (frontends: admin, clinic, patient portals)
- Node.js (backend services)
- FastAPI (Python services - potential)

**Infrastructure**: 
- Docker (containerization)
- PostgreSQL (off-chain indexed data)
- Ethereum (on-chain consent registry)
- Terraform (infrastructure as code)

**Key Libraries**:
- ethers.js (blockchain interaction)
- Whisper (voice consent - future feature)
- pnpm (monorepo package management)
- Turbo (monorepo build orchestration)

### Deployment & Environment
**Target Platform**: Web (admin dashboard, clinic console, patient portal)  
**Hosting**: Cloud (AWS/Azure TBD), local blockchain for development (Hardhat Network)  
**Compliance Requirements**: **HIPAA** (critical), GDPR (future international), SOC2 (enterprise trust)  
**Scalability Needs**: Hospital network scale (100s of providers, 1000s of patients per hospital)

### Domain Terminology
**Glossary**: Project-specific healthcare/blockchain terms (not CFP framework)

**Project-Specific Terms**:
| Term | Definition | Usage Context |
|------|------------|---------------|
| Consent Event | On-chain record of patient granting/revoking consent | Smart contract term |
| Provider Identity | NFT-based credential proving provider's license/hospital affiliation | ProviderIdentity.sol contract |
| Hospital Registry | On-chain list of verified hospitals (admin-managed) | HospitalRegistry.sol contract |
| Consent Indexer | Off-chain service that indexes blockchain events → PostgreSQL | consent-indexer service |
| EHR Gateway | Service translating consent queries to EHR system formats (Epic, Cerner) | ehr-gateway service |
| Audit Pipeline | Service capturing all access attempts → immutable log | audit-pipeline service |

---

## FUNCTIONAL GOALS

### Core Features (MVP Must-Haves)
1. **Smart Contracts** (deployed):
   - ConsentRegistry.sol (grant/revoke consent, query validity)
   - ProviderIdentity.sol (NFT-based provider credentials)
   - HospitalRegistry.sol (admin-managed hospital whitelist)
2. **Patient Portal**: View consent history, grant new consent, revoke existing consent
3. **Clinic Console**: Provider verifies consent before accessing patient data
4. **Admin Dashboard**: Hospital admin manages provider identities, monitors system
5. **Consent Indexer**: Real-time blockchain → PostgreSQL sync (fast queries)
6. **EHR Gateway**: Translate consent checks to Epic/Cerner API calls

### User Roles & Workflows
**Patient**:
1. Receives NFT wallet (hospital onboarding)
2. Grants consent to specific provider for specific data type (e.g., "Dr. Smith can access lab results for 30 days")
3. Reviews consent history in patient portal
4. Revokes consent instantly if needed (blockchain transaction)

**Provider (Doctor/Nurse)**:
1. Logs into clinic console (hospital SSO + wallet signature)
2. Looks up patient (searches by MRN or name)
3. System checks blockchain: Does patient consent exist for this provider + data type?
4. If valid: Access granted, audit log created
5. If invalid/expired: Access denied, provider sees reason ("consent expired" or "never granted")

**Hospital Admin**:
1. Manages provider identities (issue NFT credentials, revoke if provider leaves)
2. Monitors system health (consent events, access attempts, errors)
3. Runs compliance reports (who accessed what, when, consent status)

### Success Criteria
**Quantitative**:
- Consent verification latency <2 seconds (blockchain query + indexer lookup)
- 100% HIPAA audit trail coverage (every access attempt logged)
- Zero unauthorized access (consent validation never bypassed)

**Qualitative**:
- Patients report increased trust ("I know who can access my data")
- Providers report confidence in consent validity ("no legal liability fear")
- Admins report reduced compliance burden ("automated audit trails")

**Regulatory**:
- Pass HIPAA compliance audit (immutable audit trail, patient consent proof)
- Pass security penetration testing (no unauthorized data access)

---

## PROJECT RELATIONSHIPS & DEPENDENCIES

### Parent Projects
- **LTF Ecosystem**: Houses project, uses Save-Context, git hooks (for development workflow)

**NOTE**: EHR Platform does NOT use CFP framework directly (domain-specific compliance requirements, not cognitive scaffolding use case)

### Related Projects
- **EchoForge**: Shares Whisper STT integration (voice consent feature planned) - can reuse audio processing patterns
- **LTF**: Demonstrates LTF's multi-project support (context switching validated need for Project CIP system)

### Downstream Projects
- **None currently** (EHR platform is self-contained application, not framework/library)

### Knowledge Sharing
**From EHR Platform to Other Projects**:
- Multi-stakeholder complexity patterns → LTF (User State Model multi-user support informed by clinic/patient/admin roles)
- Architecture documentation value → LTF (Project CIP concept emerged from EHR's need for architecture context)
- HIPAA compliance rigor → All projects (privacy-first design principles, audit trail patterns)

**To EHR Platform from Other Projects**:
- Whisper STT integration ← EchoForge (voice consent feature: patient speaks consent, AI confirms understanding before blockchain transaction)
- Save-Context system ← LTF (preserve project state across development sessions)

### Context Switching Notes
**When Switching TO EHR Platform**:
- Emphasize: Healthcare compliance (HIPAA critical), enterprise security (not consumer simplicity), blockchain immutability patterns
- Remember: Multi-stakeholder complexity (patient, provider, admin have conflicting needs - balance required)
- Load: Smart contract architecture, service interaction diagrams, compliance requirements

**When Switching FROM EHR Platform**:
- Carry over: Compliance rigor (apply privacy-first thinking to other projects), multi-stakeholder patterns (inform User State Model multi-user design)
- Preserve: Architecture insights (monorepo structure, service boundaries, blockchain integration patterns)
- Don't assume: EHR's enterprise focus applies to consumer projects (different UX expectations)

---

## ARCHITECTURAL DECISIONS & CONSTRAINTS

### Design Principles
1. **Blockchain for Immutability**: Consent events on-chain (tamper-proof audit trail)
2. **Off-Chain for Speed**: Indexed data in PostgreSQL (fast queries, blockchain is source of truth)
3. **Patient Sovereignty**: Patient owns keys (hospital can't revoke consent without patient signature)
4. **Provider Verification**: NFT-based credentials (trustless verification, admin-controlled issuance)
5. **HIPAA Compliance First**: Every architectural decision evaluated against HIPAA requirements

### Key Technical Decisions
- **Ethereum (not private blockchain)**: Public chain for trustless verification, immutability guarantees → Higher gas costs (mitigate: batch transactions, L2 scaling later)
- **PostgreSQL indexer (not blockchain queries)**: Fast reads, complex queries possible → Data duplication risk (indexer must stay in sync - event-driven architecture critical)
- **Monorepo (pnpm + Turbo)**: Shared types across contracts/services/frontends → More complex setup, but type safety worth it
- **Hardhat (not Truffle)**: Better TypeScript support, active development → Team learning curve (newer tool)
- **Whisper for voice consent** (planned): Patient speaks consent, AI confirms understanding before transaction → Accessibility benefit, but adds complexity (validation required)

### Constraints & Trade-offs
- **Blockchain immutability**: Consent history permanent (can't delete even if patient wants) → Compliance with "right to be forgotten" (GDPR) requires off-chain deletion only (on-chain stays)
- **Gas costs**: Every consent event costs ETH → Patients must have funded wallets (hospital subsidizes? patient pays? TBD)
- **Wallet management**: Patients must secure private keys → Loss = permanent consent access loss (recovery mechanism needed - social recovery wallet?)
- **Offline access**: Blockchain requires internet → Clinic can't verify consent if network down (local cache with expiry? accept risk?)

---

## STRATEGIC CONTEXT

### How This Relates to Other Work
**Platform Strategy**: 
EHR Platform = Enterprise validation (proves LTF supports complex, compliance-heavy projects, not just consumer apps or frameworks). Success demonstrates LTF versatility.

**Revenue Model**: 
Enterprise SaaS - Hospitals pay per provider seat ($50-100/month/provider). Potential: Patient portal freemium (basic free, premium features for patient data portability).

**Research Value**: 
Blockchain + Healthcare case study (whitepaper opportunity), patient sovereignty in healthcare (conference talks), HIPAA + blockchain compliance patterns (industry contribution).

### Pivotal Moments & Key Insights
- **2025-Q3**: Smart contracts deployed (ConsentRegistry, ProviderIdentity, HospitalRegistry - foundational architecture validated)
- **2025-11-12**: Project CIP concept emerged from EHR work (recognized "extreme value" of architecture documentation - informed LTF's 3-tier context model)

### Out of Scope (Important)
- ❌ Full EHR system (Epic/Cerner replacement) - This is consent management only, integrates with existing EHRs
- ❌ General blockchain use cases - Healthcare consent only (not financial transactions, supply chain, etc.)
- ❌ International launch (MVP) - US HIPAA only initially (GDPR compliance later if validated)
- ❌ Mobile app (MVP) - Web-first (clinic/admin on desktop, patient portal responsive web - native app later)
- ❌ Voice consent (MVP) - Text-based initially (Whisper integration deferred to post-MVP)

---

## CURRENT FOCUS & ACTIVE WORK

### Active Sprint / Current Milestone
**Current**: Services architecture implementation (auth-service, consent-indexer, ehr-gateway, audit-pipeline)  
**Milestone**: End-to-end demo flow working (patient grants consent → provider verifies → access logged) - Target: 2025-12-01  
**Blockers**: EHR gateway Epic API integration (sandbox access pending), consent indexer sync reliability (blockchain reorg handling)

### Next 3 Priorities
1. **Consent Indexer Reliability**: Handle blockchain reorgs, missed events, sync gaps (production-grade event processing)
2. **Patient Portal UX**: Polish consent granting flow (wallet signature UX confusing for non-crypto users)
3. **Admin Dashboard Analytics**: Compliance reporting (who accessed what when, consent coverage by department)

### Open Questions / Decisions Needed
- **Wallet onboarding**: Hospital issues wallets (custodial, simpler) OR patients bring own wallets (self-sovereign, complex)? → Pilot both, measure patient preference
- **Gas fee payment**: Hospital subsidizes (simpler for patients) OR patients pay (true sovereignty but barrier)? → TBD based on cost analysis
- **Voice consent priority**: MVP or post-MVP? Accessibility benefit vs scope risk → Defer to post-MVP (validate core flow first)
- **Blockchain choice**: Ethereum mainnet (expensive, trustless) OR Polygon L2 (cheaper, slightly less decentralized)? → Prototype both, decide based on gas costs + security requirements

---

## INTEGRATION WITH CFP/LTF

### CFP Principles Applied
**NOTE**: EHR Platform does NOT directly use CFP framework (domain-specific application, not cognitive collaboration tool).

**Indirect connections**:
- LTF housing (uses Save-Context, git hooks, bootstrap scripts from LTF tooling)
- User State Model multi-user patterns informed by EHR's multi-stakeholder complexity (patient, provider, admin roles)

### LTF Tooling Used
- Save-Context snapshots (preserve project state across development sessions)
- Git hooks (commit message standards)
- Project-Specific CIP (this file) loaded on context switch to EHR work

### How This Extends Framework
**Doesn't extend CFP** (separate domain), but **validates LTF multi-project support**:
- Context switching between EHR (enterprise, blockchain, healthcare) and LTF/EchoForge (framework, consumer) proves Project CIP system works
- Architecture documentation needs → informed Project CIP template design
- Multi-stakeholder patterns → informed User State Model multi-user support concept

---

## GLOSSARY QUICK REFERENCE

**Blockchain/Smart Contract Terms**:
- **Consent Event**: On-chain record (grant/revoke)
- **Provider Identity**: NFT credential (license proof)
- **Hospital Registry**: On-chain whitelist (admin-managed)
- **Gas**: Transaction fee (ETH paid for blockchain writes)

**Service Architecture Terms**:
- **Consent Indexer**: Blockchain → PostgreSQL sync service
- **EHR Gateway**: Consent API → EHR system translator
- **Audit Pipeline**: Access attempt logger (immutable)
- **Auth Service**: SSO + wallet signature authentication

**Healthcare Terms**:
- **HIPAA**: Health Insurance Portability and Accountability Act (US healthcare privacy law)
- **MRN**: Medical Record Number (patient identifier)
- **Epic/Cerner**: Major EHR system vendors (integration targets)
- **PHI**: Protected Health Information (regulated data)

---

## VERSION HISTORY & EVOLUTION

### Major Milestones
- **2025-Q3**: Smart contracts deployed (ConsentRegistry, ProviderIdentity, HospitalRegistry)
- **2025-Q4**: Services architecture designed (monorepo structure, service boundaries)
- **2025-11-12**: Project CIP created (architecture documentation formalized)

### Lessons Learned
✅ **Worked Well**:
- Monorepo structure (shared types prevent contract/service drift)
- Hardhat for contract development (TypeScript support excellent)
- Event-driven indexer (blockchain as source of truth, PostgreSQL for speed)

⚠️ **Challenges**:
- Wallet UX for non-crypto users (signature prompts confusing - need better education)
- Gas cost unpredictability (ETH price fluctuates - need cost cap or L2 migration)
- EHR API inconsistency (Epic vs Cerner different patterns - abstraction layer critical)

🔄 **Pivots**:
- From "blockchain medical records" → "blockchain consent only" (narrower scope, clearer value)
- From "patient-pays-gas" → "hospital subsidizes" (lower barrier, better UX)

---

## USAGE NOTES FOR AI

### When Loading This CIP
**Context to Emphasize**:
- Healthcare compliance (HIPAA critical, legal consequences if violated)
- Enterprise security (multi-stakeholder trust, blockchain immutability)
- Architecture complexity (monorepo, multiple services, blockchain + traditional stack)

**Related CIPs to Consider Loading**:
- `CIP_Project_ECHO.md` - Shares Whisper integration (voice consent feature)
- `CIP_Project_LTF.md` - Meta-framework context (how EHR fits in ecosystem)

### When Context Switching Away
**What to Preserve**:
- Compliance rigor (privacy-first design applies to all projects)
- Multi-stakeholder patterns (patient/provider/admin role complexity)
- Architecture documentation value (influenced Project CIP template)

**What NOT to Carry Over**:
- Enterprise complexity (don't apply to consumer projects like EchoForge)
- Blockchain patterns (not all projects need immutability)
- Healthcare terminology (domain-specific)

---

**Template Version**: Based on `Project_CIP_Template.md` v1.0  
**Next Update**: After end-to-end demo completion (capture service integration insights, UX validation findings)
