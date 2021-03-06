import Vue from 'vue'
import DatePicker from 'vue2-datepicker'; import 'vue2-datepicker/index.css';
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import Toast from 'vue-toastification'; import 'vue-toastification/dist/index.css';
import VModal from 'vue-js-modal'
import { Sketch } from 'vue-color'


// Boostrap components
import {
    NavbarPlugin,
    ButtonPlugin,
    FormPlugin,
    PaginationPlugin,
    BootstrapVueIcons,
    CardPlugin,
    FormTextareaPlugin,
    FormInputPlugin,
    FormGroupPlugin,
    TablePlugin,
    InputGroupPlugin,
    LayoutPlugin,
    FormSelectPlugin,
    FormCheckboxPlugin,
    TabsPlugin,
    FormTagsPlugin,
    FormSpinbuttonPlugin,
    ModalPlugin,
    DropdownPlugin,
    ImagePlugin
} from 'bootstrap-vue'

// General componentes
import componentHeaderList from './components/component-header-list.vue'
import componentHeaderForm from './components/component-header-form.vue'
import componentSearchList from './components/component-search-list.vue'

// Libraries
import VueRouter from 'vue-router'

// Plugins
import http from './plugins/http'
import tools from './plugins/tools'

// Components

Vue.component('color-picker', Sketch)
Vue.component('component-datepicker', DatePicker)
Vue.component('component-header-list', componentHeaderList)
Vue.component('component-header-form', componentHeaderForm)
Vue.component('component-search-list', componentSearchList)
Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(BootstrapVueIcons)
Vue.use(ButtonPlugin)
Vue.use(FormPlugin)
Vue.use(PaginationPlugin)
Vue.use(CardPlugin)
Vue.use(FormInputPlugin)
Vue.use(FormTextareaPlugin)
Vue.use(FormGroupPlugin)
Vue.use(TablePlugin)
Vue.use(InputGroupPlugin)
Vue.use(LayoutPlugin)
Vue.use(FormSelectPlugin)
Vue.use(FormCheckboxPlugin)
Vue.use(TabsPlugin)
Vue.use(FormTagsPlugin)
Vue.use(FormSpinbuttonPlugin)
Vue.use(ModalPlugin)
Vue.use(DropdownPlugin)
Vue.use(NavbarPlugin)
Vue.use(ImagePlugin)

Vue.use(VueRouter)

Vue.use(http)
Vue.use(tools, system.current_user)

Vue.use(VModal)
Vue.use(Toast, {
    timeout: 1500,
    hideProgressBar: true,
    icon: {
        iconClass: 'xmark'
    },
    position: 'bottom-right'
})

// libraries
library.add(fas)

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

    app.$mount('#app') // Mount app
}