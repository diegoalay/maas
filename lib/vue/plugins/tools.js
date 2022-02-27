export default {

    install (Vue, current_user) {
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

        const getDayName = (month_id, locale = null) => {

            let objDate = new Date();
            objDate.setDate(month_id);
            objDate.setMonth(1);

            let languaje = locale ? locale : getLocale()

            const day = objDate.toLocaleString(languaje, { weekday: 'long' })

            return (day.charAt(0).toUpperCase() + day.slice(1))
        }

        const getLocale = () => {
            if (navigator.languages != undefined)
              return navigator.languages[0]
            return navigator.language
        }

        const isAdmin = () => {
            if (current_user.role === 'admin') return true

            return false
        }

        Vue.prototype.tools = {
            isMobile,
            screenWidth,
            getDayName,
            isAdmin
        }
    }
}