if (document) {
    document.onreadystatechange = () => {
        if (document.readyState === 'complete') {
            const topbar = document.getElementsByClassName("top-navbar")[0]
            topbar.style.visibility = "visible"
        } // wait to show topbar
    }
}