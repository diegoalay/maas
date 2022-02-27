export default {

    install (Vue) {
        const screenWidth = () => {
            return screen.width
        }

        const isMobile = () => {
            if (screenWidth() <= 760 ) {
                return true;
            }
            else {
                return false;
            }
        }

        Vue.prototype.tools = {
            isMobile,
            screenWidth,
        }
    }
}