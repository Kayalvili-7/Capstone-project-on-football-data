## 🎯 Objective  
The primary goal of this project is to analyze football datasets to extract meaningful insights that can support **strategic decision-making**. Key objectives include:  
- Evaluating **player and team performance**.  
- Understanding **player market value**.  
- Analyzing **team and player attributes**.  
- Identifying patterns in **attendance, referee decisions, substitutions, and in-game events**.  
- Applying **machine learning models** for predictive insights.  

---

## 🛠 Project Requirements  

- **Tools Used**: Anaconda, Jupyter Notebook, Tableau, SQL Workbench.  
- **Datasets**:  
  - `Appearance`  
  - `Games`  
  - `GameLineup`  
  - `GameEvent`  
  - `Players`  

---

## 🔎 Key Analysis and Findings  

### 1. Performance Analysis  
- **Top Goal Scorers**: Aron Johannsson (93 goals) and Jozy Altidore (65 goals).  
- **Top Teams**:  
  - Best home club: *Borussia Verein* (410 goals).  
  - Best away club: *Borussia Dortmund* (282 goals).  
- **Probabilities**:  
  - Home team winning → 45%.  
  - Goal scored after substitution → 84%.  
- **Hypothesis Testing**: No significant difference between home and away goals (p-value > 0.05).  

---

### 2. Player Profile and Market Value Analysis  
- **Regression Models**:  
  - Linear Regression: Very weak relationship between assists and market value (R² = 0.0047).  
  - Multiple Linear Regression: Low predictive power (R² = 0.0044).  
- **Contract Insights**:  
  - Club ID 18 → 200+ expiring contracts.  
  - Club ID 24 → 190 expiring contracts.  
  - Midfielder with contract expiring in 2026 valued at **€25M+**.  
- **Player Demographics**:  
  - 80% of players are **right-footed**.  
  - Top player-producing nations: USA (2500+), Germany (~1000).  

---

### 3. Team and Competition Analysis  
- **Home vs Away Wins**: L1 competition had the highest home (536) and away (332) wins.  
- **Goals per Game**: USC & DFL averaged **13 goals per game**.  
- **Attendance**: DFL attracted the **highest average attendance (81,360)**.  
- **Competitive Balance**: POCP & USC showed the most balanced competition (smallest goal difference).  

---

### 4. Event and Substitution Analysis  
- **Most Active Competition (Events)**: L1 → 992 substitutions, 104 goals, 47 cards.  
- **Timing Insights**:  
  - Peak activity between **61-75 minutes**: 2749 substitutions, 33 goals, 175 assists.  
- **Refereeing**:  
  - Chi-Square test → No significant association between red cards and losing (p = 0.90).  

---

### 5. Machine Learning Models  
- **K-Nearest Neighbors (KNN)**: Predicted attendance with **62% accuracy**, better at identifying high-attendance matches.  
- **K-Means Clustering**:  
  - Younger players (<30) spread across all clusters.  
  - Older players (>30) grouped in lower performance clusters.  
- **Logistic Regression**: ROC curve (AUC = 0.55) → Limited predictive power for goal prediction.  

---

## 💡 Business Recommendations  
- **Player Recruitment**: Scout versatile players and adapt strategies for stronger home performances.  
- **Predictive Modeling**: Improve draw predictions with more features and advanced algorithms.  
- **Market Value**: Include factors like fan appeal & economic trends for accurate valuations.  
- **Fan Engagement**: Enhance stadium experience to boost attendance & loyalty.  
- **Strategic Play**: Encourage bold, high-scoring play to attract sponsors and fans.  
- **Contract Management**: Adopt proactive strategies and maintain backups for roster stability.  
- **Refereeing Insights**: Assign strict referees to high-stakes matches for fair play.  

---

## 🛠 Tools & Technologies  
- **Python** (Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn).  
- **SQL Workbench** (data extraction & queries).  
- **Tableau** (dashboards & visualization).  
- **Jupyter Notebook** (analysis & documentation).  

---

## 🔮 Future Scope  
- Enhance ML models with **advanced algorithms** (Random Forest, XGBoost, Neural Networks).  
- Incorporate **real-time match data** for live predictive insights.  
- Expand datasets to include **injuries, transfers, and financial data**.  
- Develop an **interactive dashboard** (Power BI / Tableau) for dynamic reporting.  
- Explore **deep learning approaches** for video-based player performance analysis.  

---
