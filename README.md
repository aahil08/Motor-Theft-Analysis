# New Zealand Motor Vehicle Theft  
**Data-Driven Insights for Stakeholders**  
*Prepared for: New Zealand Police – National Prevention & Intelligence  
Date: 24 April 2025*

---

## 1 | Executive Snapshot  

> Vehicle thefts are climbing ~**3 % per year (2020-24)**. Summer evenings and long-weekends add an extra **+18 % monthly spike**. A small set of mainstream body styles (median age ≈ 9 yrs) represents the bulk of crime, while late-model luxury SUVs and sports coupes are a fast-growing secondary target. Auckland posts the largest volumes, but **Southland is highest-risk once normalised (5.2 thefts per 1 000 registered vehicles)**. Targeted, season-aware policing and tailored public messaging can maximise crime-prevention ROI.

---

## 2 | Report Purpose & Audience  

| **Stakeholder**          | **Decision Need**                           | **Report Value**                                              |
|--------------------------|---------------------------------------------|---------------------------------------------------------------|
| District Commanders      | Patrol rostering & resource allocation      | Pin-points high-risk regions, days, and vehicle segments      |
| Prevention & Comms Units | Public-awareness content                    | Timely talking points and safety tips                         |
| Strategy & Policy        | Budget & legislative planning              | Evidence base for funding bids & tech-security subsidies      |

---

## 3 | Objectives Addressed  

1. **WHEN** are vehicles stolen?  
2. **WHAT** vehicles are most vulnerable?  
3. **WHERE** do thefts cluster, and how does density shift risk?  
*Secondary goals:* enhance public vigilance, guide deployment, and inform future crime-reduction strategy.

---

## 4 | Data & Methodology  

| **Source**        | **Records** | **Key Fields**                                           | **Cleansing Steps**             |
|-------------------|-------------|----------------------------------------------------------|---------------------------------|
| `Stolen_Vehicles` | 58 642      | `theft_date`, `body_type`, `manufacture_year`, `luxury_flag`, `colour` | Removed 1.7 % nulls/dupes       |
| `Locations`       | 58 642      | `region`, `meshblock`, `population`, `density`           | Joined on `incident_id`         |

*SQL CTEs* aggregated theft counts by time, vehicle attributes, and region. Results exported to four Excel summaries (`Obj_1–Obj_4`) for visual QA.

---

## 5 | Key Findings & Implications  

### 5.1  WHEN – Temporal Patterns  

| **Slice**  | **Result**                       | **Implication**                                   |
|------------|----------------------------------|---------------------------------------------------|
| YoY trend  | +3 % compound growth (’20-’24)   | Sustained resource need                           |
| Monthly    | Dec-Mar +18 % vs Jun-Aug         | Launch *Summer Secure* campaign; surge ANPR units |
| Weekday    | Mon 16 %, Tue 15 %, Fri 15 %     | Evening patrol focus; neighbourhood-watch alerts  |
| Hour       | 18:00-23:00 = 41 % of incidents  | Stake-outs at commuter carparks                   |

### 5.2  WHAT – Vehicle Characteristics  

|                | **Standard Segment** | **Luxury Segment** |
|----------------|----------------------|--------------------|
| Share of theft | 75-85 %              | 15-25 %            |
| Median age     | 9.2 yrs              | 4.6 yrs            |
| Top body types | Station Wagon, Saloon, Hatchback | SUV, Sports Coupe |
| Dominant colour| Dark Grey 14 %, Silver 13 % | Black 12 % |

*Insight:* Older factory security remains exploitable; luxury models need relay-attack defence & GPS tracking.

### 5.3  WHERE – Geographic Patterns  

| **Region**  | **Thefts** | **Rate /1 000 Veh.** | **Density (pop/km²)** | **Notable Mix**           |
|-------------|-----------:|----------------------:|----------------------:|---------------------------|
| Auckland    | 18 420     | 4.8                  | 1 210                 | Sedans dominate           |
| Canterbury  | 8 960      | 3.9                  | 720                   | Mirrors Auckland          |
| Wellington  | 6 230      | 4.6                  | 900                   | Hatchbacks high           |
| **Southland** | **1 150** | **5.2**              | 10                    | Pick-ups & farm utes      |

*Density effect:* High-density suburbs offer anonymity; rural areas suffer isolation & low CCTV – each needs distinct tactics.

---

## 6 | Recommendations  

1. **Seasonal Surge (Dec–Mar & Labour Day)**  
   * Deploy mobile ANPR & hi-viz patrols at retail/holiday hotspots.  
   * Social & radio push: “Lock it, hide it, keep it.”  

2. **Protect the Vulnerable Fleet (8-plus-year-old cars)**  
   * Subsidise steering-wheel locks / OBD blockers with insurers & MTA.  

3. **Counter Luxury-Vehicle Rings**  
   * FAR-U (Faraday-pouch) giveaways at dealerships; CBD geofence auto-alerts.  

4. **Density-Aware Rostering**  
   * Urban evenings → multi-storey carparks (Mon/Tue/Fri).  
   * Rural days → random sweeps near farm-equipment yards & rail park-and-rides.  

5. **Integrated Data Hub**  
   * Live feed linking stolen-vehicle SQL tables, national CCTV registry, and private-tow logs.  

---

## 7 | Implementation Timeline  

| **Date** | **Deliverable**                  | **Owner**            | **KPI**                                   |
|----------|----------------------------------|----------------------|-------------------------------------------|
| May 2025 | Launch *Summer Secure* media kit | Police Comms         | >30 % reach in target districts           |
| Jun 2025 | Funding bid for device subsidy   | Strategy & Finance   | Cabinet approval                          |
| Q3 2025  | Auckland CBD geofence-alert pilot| Auckland District    | –10 % luxury-SUV theft YoY                |

---

## 8 | Appendices  

* **A. SQL Query Library** – snippets for `YEAR_AGG`, `MONTH_AGG`, `VEHICLE_TYPE_AGG`, `REGION_RATE`  
* **B. Colour × Body-Type Matrix** – Top-10 body types vs top-7 colours with counts  
* **C. Full Region Dashboard** – Excel pivots from `Obj_1–Obj_4`  

---

*For feedback or collaboration, please open an issue or submit a pull request.*


