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

        const getWeekNumber = () => {
            // ref https://weeknumber.com/how-to/javascript
            var date = new Date();
            date.setHours(0, 0, 0, 0);
            // Thursday in current week decides the year.
            date.setDate(date.getDate() + 3 - (date.getDay() + 6) % 7);
            // January 4 is always in week 1.
            var week1 = new Date(date.getFullYear(), 0, 4);
            // Adjust to Thursday in week 1 and count number of weeks from date to week1.
            return 1 + Math.round(((date.getTime() - week1.getTime()) / 86400000 - 3 + (week1.getDay() + 6) % 7) / 7);
        }

        Vue.prototype.tools = {
            isMobile,
            screenWidth,
            getDayName,
            getWeekNumber,
            isAdmin
        }
    }
}