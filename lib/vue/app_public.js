import Vue from 'vue'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import Toast from "vue-toastification"; import "vue-toastification/dist/index.css";


// Boostrap components
import {
    ButtonPlugin,
    FormPlugin,
    CardPlugin,
    FormInputPlugin,
    FormGroupPlugin,
    LayoutPlugin,
} from 'bootstrap-vue'

// Libraries
import VueRouter from 'vue-router'

// Plugins
import http from './plugins/http'

Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(ButtonPlugin)
Vue.use(FormPlugin)
Vue.use(CardPlugin)
Vue.use(FormInputPlugin)
Vue.use(CardPlugin)
Vue.use(FormInputPlugin)
Vue.use(FormGroupPlugin)
Vue.use(FormGroupPlugin)
Vue.use(LayoutPlugin)

Vue.use(VueRouter)

Vue.use(http)
Vue.use(tools)

Vue.use(Toast, {
    timeout: 1500,
    hideProgressBar: true,
    position: 'bottom-right'
})

// Mount component
export default (base_path, routes=[]) => {
    let app_builder = { } // App builder

    // Routes
    app_builder['router'] = new VueRouter({
        linkActiveClass: 'is-active',
        mode: 'history',
        hash: false,
        base: base_path,
        routes: routes
    })

    let app = new Vue(app_builder) // Building Vue app

    app.$mount("#app") // Mount app
}