<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="portfoilio1.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>My Portfolio</title>
</head>

<body>
    <header class="header">
        <h1>Portfolio</h1>
        <nav class="navbar">
            <a href="#home" class="active">Home</a>
            <a href="#about">About me</a>
            <a href="#education">Education</a>
            <div class="dropdown">
                <a class="nav-link" id="skills-nav-link">Skills <i class="fa-solid fa-caret-down"></i></a>
                <ul class="dropdown-content" id="skills-submenu"></ul>
            </div>
            <a href="#contact">Contact</a>
            <a href="#"> Search</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" id="searchInput" placeholder="Search a skill..." onkeyup="searchCourse()">
        </nav>
        <div class="menu-icon" id="menu-icon">
            <i class="fas fa-bars"></i>
        </div>
    </header>

    <section class="home" id="home">
        <div class="home-content">
            <h3>Hi, Myself</h3>
            <h1>Sahil Chawan</h1>
            <h3>And I'm a <span>Frontend Developer</span></h3>
            <p>I am passionate about crafting beautiful and functional user interfaces. I specialize in turning ideas
                into responsive, interactive web experiences.</p>
            <div class="social-media">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="https://www.instagram.com/_sahil12c5_/" target="_blank"><i
                        class="fa-brands fa-instagram"></i></a>
                <a href="https://www.linkedin.com/in/sahilchawan/" target="_blank"><i
                        class="fa-brands fa-linkedin-in"></i></a>
            </div>
        </div>
    </section>

    <section class="about" id="about">
        <div class="about-img">
            <img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" alt="A portrait of Sahil">
        </div>
        <div class="about-content">
            <h2 class="heading">ABOUT <span>Me</span></h2>
            <h3>Frontend Developer</h3>
            <p>I am a dedicated and passionate third-year Information Technology student at Pravin Rohidas Patil College of Engineering and Technology. My journey in tech is driven by a love for problem-solving and building things from the ground up.

            I have a strong foundation in languages like Java and practical experience in web development with HTML, CSS, and JavaScript. I enjoy turning complex problems into simple, elegant code.

            I am actively seeking a software development internship where I can contribute to real-world projects and continue to grow as a developer. When I'm not coding, I enjoy exploring new technologies, playing video games and watching movies</p>
        </div>
    </section>

    <section class="education" id="education">
        <h2 class="heading">My <span>Education</span></h2><br>
        <div class="education-container">
            <div class="education-box">
                <i class="fa-solid fa-graduation-cap"></i>
                <h3>Bachelor's Degree (2023-2027)</h3>
                <p>Currently a third-year student pursuing a Bachelor of Engineering in Information Technology at Pravin Rohidas Patil College of Engineering and Technology. I am focusing on building skills in Software and Web Development and am eager to apply them in a practical setting.</p>
            </div>
            <div class="education-box">
                <i class="fa-solid fa-school"></i>
                <h3>HSC (2021-2023)</h3>
                <p>Completed my Higher Secondary Certificate (HSC) in the Science stream from Shri T P Bhatia College of Science, Mumbai (Maharashtra State Board). Core subjects included Physics, Chemistry, Mathematics, and Computer Science.</p>
            </div>
        </div>
    </section>

    <section class="skill" id="skill">
        <h2 class="heading">My <span>Skills</span></h2>
        <div class="skill-container">
            <div class="skill-box">
                <i class="fa-brands fa-java"></i>
                <h3>Java</h3>
            </div>
            <div class="skill-box">
                <i class="fa-brands fa-html5"></i>
                <h3>HTML</h3>
            </div>
            <div class="skill-box">
                <i class="fa-brands fa-css3-alt"></i>
                <h3>CSS</h3>
            </div>
            <div class="skill-box">
                <i class="fa-brands fa-js"></i>
                <h3>JavaScript</h3>
            </div>
        </div>
    </section>

    <section class="contact" id="contact">
        <h2 class="heading">Contact <span>Me</span></h2>
        <form id="contactForm" action="ContactServlet" method="post">
            <div class="input-box">
                <input type="text" id="fullName" placeholder="Full Name" name="uname" required>
                <input type="email" id="emailAddress" placeholder="Email Address" name="uemail" required>
            </div>
            <div class="input-box">
                <input type="tel" id="mobileNumber" placeholder="Mobile Number" name="unumber" required>
                <input type="text" id="emailSubject" placeholder="Email Subject" name="usubject" required>
            </div>
            <textarea id="message" cols="30" rows="10" placeholder="Your Message" name="umessage" required></textarea>
            <input type="submit" value="Send Message" class="btn">
        </form>
        <div id="form-status"></div>
    </section>

    <footer class="footer">
        <div class="footer-text">
            <p>Copyright &copy; 2025 @Sahil Chawan | All Rights Reserved.</p>
        </div>
        <div class="footer-icontop">
            <a href="#home"><i class="fa-solid fa-angle-up"></i></a>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const menuIcon = document.getElementById('menu-icon');
            const navbar = document.querySelector('.navbar');
            menuIcon.addEventListener('click', () => {
                navbar.classList.toggle('show');
            });

            const skillsNavLink = document.getElementById('skills-nav-link');
            const skillsSubmenu = document.getElementById('skills-submenu');
            const skillBoxes = document.querySelectorAll('.skill-box');

            skillsNavLink.addEventListener('click', (event) => {
                event.stopPropagation();
                skillsSubmenu.classList.toggle('show');
                skillsNavLink.classList.toggle('open');
            });

            window.addEventListener('click', () => {
                if (skillsSubmenu.classList.contains('show')) {
                    skillsSubmenu.classList.remove('show');
                    skillsNavLink.classList.remove('open');
                }
            });

            skillBoxes.forEach(box => {
                const skillName = box.querySelector('h3').textContent.trim();
             
                box.setAttribute('id', skillId);
                const listItem = document.createElement('li');
                const link = document.createElement('a');
                link.textContent = skillName;
                link.href = `#${skillId}`;
                link.addEventListener('click', (e) => {
                    e.preventDefault();
                    skillsSubmenu.classList.remove('show');
                    skillsNavLink.classList.remove('open');
                    const targetElement = document.getElementById(skillId);
                    if (targetElement) {
                        targetElement.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
                listItem.appendChild(link);
                skillsSubmenu.appendChild(listItem);
            });

            const sections = document.querySelectorAll('section');
            const navLinks = document.querySelectorAll('header nav a');
            window.onscroll = () => {
                let currentSectionId = '';
                sections.forEach(sec => {
                    let top = window.scrollY;
                    let offset = sec.offsetTop - 150;
                    let height = sec.offsetHeight;
                    let id = sec.getAttribute('id');
                    if (top >= offset && top < offset + height) {
                        currentSectionId = id;
                    }
                });
                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${currentSectionId}`) {
                        link.classList.add('active');
                    }
                });
                if (currentSectionId === 'skill') {
                    skillsNavLink.classList.add('active');
                } else {
                    skillsNavLink.classList.remove('active');
                }
            };
        });

        window.searchCourse = function() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const skillBoxes = document.querySelectorAll('.skill-box');
            skillBoxes.forEach(box => {
                const skillName = box.querySelector('h3').textContent.toLowerCase();
                if (skillName.includes(searchTerm) && searchTerm !== '') {
                    box.classList.add('highlight');
                    box.scrollIntoView({ behavior: 'smooth', block: 'center' });
                } else {
                    box.classList.remove('highlight');
                }
            });
        };
    </script>
</body>
</html>