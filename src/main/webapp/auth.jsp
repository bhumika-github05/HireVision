<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireVision Auth</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/auth.css">


</head>
<body>
<main class="page-shell">
    <section class="brand-panel" aria-label="HireVision introduction">
        <div>
            <div class="brand">
                <div class="brand-mark">
                    <i class="bi bi-columns-gap"></i>
                </div>
                <div>
                    <div class="brand-name">Hire<span>Vision</span></div>
                    <div class="brand-tagline">Smart Hiring, Better Future</div>
                </div>
            </div>

            <div class="hero-copy">
                <h1>
                    Find the <span class="blue">Right Job.</span><br>
                    Hire the <span class="violet">Right Talent.</span>
                </h1>
                <p>HireVision connects talented people with great opportunities.</p>
            </div>

            <div class="features">
                <div class="feature">
                    <div class="feature-icon">
                        <i class="bi bi-briefcase"></i>
                    </div>
                    <div>
                        <h2>For Job Seekers</h2>
                        <p>Discover jobs, apply, and build your career.</p>
                    </div>
                </div>

                <div class="feature">
                    <div class="feature-icon">
                        <i class="bi bi-buildings"></i>
                    </div>
                    <div>
                        <h2>For Recruiters</h2>
                        <p>Post jobs, find candidates, and grow your team.</p>
                    </div>
                </div>

                <div class="feature">
                    <div class="feature-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <div>
                        <h2>Secure &amp; Reliable</h2>
                        <p>Your data is safe with us.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="illustration" aria-hidden="true">
            <div class="plant"></div>
            <div class="person-left"></div>
            <div class="screen">
                <div class="candidate-row"></div>
                <div class="candidate-row"></div>
                <div class="candidate-row"></div>
            </div>
            <div class="lens"></div>
            <div class="person-right"></div>
        </div>
    </section>

    <section class="auth-panel" aria-label="Authentication">
        <div class="auth-card">
            <div class="tabs">
                <button type="button" class="tab active" id="loginTab" onclick="showLogin()">Login</button>
                <button type="button" class="tab" id="registerTab" onclick="showRegister()">Register</button>
            </div>

            <div class="form-view active" id="loginForm">
                <div class="lock-badge">
                    <i class="bi bi-lock"></i>
                </div>
                <h2 class="form-heading">Welcome Back!</h2>
                <p class="form-subtitle">Login to your account</p>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="field">
                        <label for="loginEmail">Email</label>
                        <div class="control">
                            <i class="bi bi-envelope"></i>
                            <input id="loginEmail" type="email" name="email" placeholder="Enter your email" required>
                        </div>
                    </div>

                    <div class="field">
                        <label for="loginPassword">Password</label>
                        <div class="control">
                            <i class="bi bi-lock"></i>
                            <input id="loginPassword" type="password" name="password" placeholder="Enter your password" required>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">Login</button>
                </form>

                <p class="switch-copy">
                    Don't have an account?
                    <button type="button" onclick="showRegister()">Register</button>
                </p>
            </div>

            <div class="form-view" id="registerForm">
                <div class="lock-badge">
                    <i class="bi bi-person-plus"></i>
                </div>
                <h2 class="form-heading">Create Account</h2>
                <p class="form-subtitle">Register with HireVision</p>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="field">
                        <label for="fullName">Full Name</label>
                        <div class="control">
                            <i class="bi bi-person"></i>
                            <input id="fullName" type="text" name="fullName" placeholder="Enter your full name" required>
                        </div>
                    </div>

                    <div class="field">
                        <label for="registerEmail">Email</label>
                        <div class="control">
                            <i class="bi bi-envelope"></i>
                            <input id="registerEmail" type="email" name="email" placeholder="Enter your email" required>
                        </div>
                    </div>

                    <div class="field">
                        <label for="registerPassword">Password</label>
                        <div class="control">
                            <i class="bi bi-lock"></i>
                            <input id="registerPassword" type="password" name="password" placeholder="Create your password" required>
                        </div>
                    </div>

                    <div class="field">
                        <label for="role">Role</label>
                        <div class="control">
                            <i class="bi bi-person-badge"></i>
                            <select id="role" name="role" required>
                                <option value="Candidate">Candidate</option>
                                <option value="Recruiter">Recruiter</option>
                            </select>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">Register</button>
                </form>

                <p class="switch-copy">
                    Already have an account?
                    <button type="button" onclick="showLogin()">Login</button>
                </p>
            </div>
        </div>
    </section>
</main>

<script>
    const loginTab = document.getElementById("loginTab");
    const registerTab = document.getElementById("registerTab");
    const loginForm = document.getElementById("loginForm");
    const registerForm = document.getElementById("registerForm");

    function showRegister(){
        loginTab.classList.remove("active");
        registerTab.classList.add("active");
        loginForm.classList.remove("active");
        registerForm.classList.add("active");
    }

    function showLogin(){
        registerTab.classList.remove("active");
        loginTab.classList.add("active");
        registerForm.classList.remove("active");
        loginForm.classList.add("active");
    }
</script>
</body>
</html>
