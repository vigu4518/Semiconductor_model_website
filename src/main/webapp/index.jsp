<%@ page language="java" %>
<html>
<head>
    <title>Semiconductor Threshold Voltage Predictor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css?v=2">
    <script>
        function updateForm() {
            var value = document.getElementById("modelType").value;
            document.getElementById("twoParam").style.display = "none";
            document.getElementById("threeParam").style.display = "none";
            document.getElementById("formSection").style.display = "none";

            if (value === "2") {
                document.getElementById("twoParam").style.display = "block";
                document.getElementById("formSection").style.display = "block";
            } else if (value === "3") {
                document.getElementById("threeParam").style.display = "block";
                document.getElementById("formSection").style.display = "block";
            }
        }
    </script>
</head>
<body>

<div class="page-wrapper">

    <!-- Header -->
    <header class="site-header">
        <div class="header-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                <rect x="2" y="7" width="20" height="10" rx="2"/>
                <path d="M7 7V5a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v2"/>
                <line x1="12" y1="12" x2="12" y2="12.01"/>
                <path d="M8 12h.01M16 12h.01"/>
            </svg>
        </div>
        <div>
            <h1>Semiconductor Threshold Voltage Predictor</h1>
            <p class="header-subtitle">ML-powered Vth estimation for semiconductor devices</p>
        </div>
    </header>

    <!-- Info Cards -->
    <div class="info-grid">
        <div class="info-card">
            <div class="info-card-label">2-Parameter Model</div>
            <div class="info-card-desc">Uses Implant Dose &amp; Oxide Thickness. Channel Length is held constant internally.</div>
        </div>
        <div class="info-card">
            <div class="info-card-label">3-Parameter Model</div>
            <div class="info-card-desc">Uses Implant Dose, Oxide Thickness, and Channel Length for higher accuracy.</div>
        </div>
    </div>

    <!-- Model Selector -->
    <div class="card">
        <label class="field-label" for="modelType">Select Prediction Model</label>
        <select id="modelType" onchange="updateForm()" class="select-field">
            <option value="">-- Choose a model --</option>
            <option value="2">2 Parameter Model</option>
            <option value="3">3 Parameter Model</option>
        </select>
    </div>

    <!-- Form Section -->
    <div id="formSection" style="display:none;" class="card form-card">

        <!-- 2 Param Form -->
        <div id="twoParam" style="display:none;">
            <h2 class="form-title">2 Parameter Model</h2>
            <form action="process" class="input-form">
                <input type="hidden" name="type" value="2">
                <div class="field-group">
                    <label class="field-label" for="p1_2">Implant Dose</label>
                    <input type="text" id="p1_2" name="p1" class="text-field" placeholder="e.g. 1.2e17">
                </div>
                <div class="field-group">
                    <label class="field-label" for="p2_2">Oxide Thickness (nm)</label>
                    <input type="text" id="p2_2" name="p2" class="text-field" placeholder="e.g. 5.0">
                </div>
                <button type="submit" class="btn-predict">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                    Run Prediction
                </button>
            </form>
        </div>

        <!-- 3 Param Form -->
        <div id="threeParam" style="display:none;">
            <h2 class="form-title">3 Parameter Model</h2>
            <form action="process" class="input-form">
                <input type="hidden" name="type" value="3">
                <div class="field-group">
                    <label class="field-label" for="p1_3">Implant Dose</label>
                    <input type="text" id="p1_3" name="p1" class="text-field" placeholder="e.g. 1.2e17">
                </div>
                <div class="field-group">
                    <label class="field-label" for="p2_3">Oxide Thickness (nm)</label>
                    <input type="text" id="p2_3" name="p2" class="text-field" placeholder="e.g. 5.0">
                </div>
                <div class="field-group">
                    <label class="field-label" for="p3_3">Channel Length (µm)</label>
                    <input type="text" id="p3_3" name="p3" class="text-field" placeholder="e.g. 0.18">
                </div>
                <button type="submit" class="btn-predict">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                    Run Prediction
                </button>
            </form>
        </div>

    </div>

    <% if (request.getAttribute("result") != null) { %>
    <div class="result-card">
        <div class="result-label">Predicted Threshold Voltage (Vth)</div>
        <div class="result-value">${result} <span class="result-unit">V</span></div>

        <div class="result-inputs">
            <div class="result-input-title">Inputs Used</div>
            <div class="result-input-grid">
                <div class="result-input-item">
                    <span class="result-input-label">Implant Dose</span>
                    <span class="result-input-value">${param.p1}</span>
                </div>
                <div class="result-input-item">
                    <span class="result-input-label">Oxide Thickness</span>
                    <span class="result-input-value">${param.p2} nm</span>
                </div>
                <% if ("3".equals(request.getParameter("type"))) { %>
                <div class="result-input-item">
                    <span class="result-input-label">Channel Length</span>
                    <span class="result-input-value">${param.p3} µm</span>
                </div>
                <% } %>
                <div class="result-input-item">
                    <span class="result-input-label">Model Used</span>
                    <span class="result-input-value">${param.type}-Parameter</span>
                </div>
            </div>
        </div>
    </div>
    <% } %>

</body>
</html>
