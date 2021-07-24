const navbar = document.querySelector("#mainNav")

// On events page, we want a header with fancy wallpaper overlaying the navbar
if (typeof navbar != "undefined" && navbar != null) {
    navbar.classList.add("transparent-nav")
}

window.addEventListener('scroll', (e) => {
    if (window.scrollY > 0) {
        navbar.classList.add("scrolling-nav")
    }
    else {
        navbar.classList.remove("scrolling-nav")
    }
})
