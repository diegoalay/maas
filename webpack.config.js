const fs = require('fs')
const path = require('path')
const webpack = require('webpack')
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const TerserPlugin = require('terser-webpack-plugin');

let webpackConfig = []

module.exports = env => {

    // set mode
    env.mode = env.mode ? env.mode : 'development'
    env.watch = env.watch ? env.watch : false
    var production = env.mode == 'production' ? true : false

    let webpackBase = {
        watch: env.watch == 'true',
        mode: production ? 'production' : 'development',
        performance: { hints: false },
        optimization: !production ? { minimize: false } :  {
            minimizer: [
                new TerserPlugin({
                    terserOptions: {
                        output: {
                            comments: false
                        }
                    }
                })
            ]
        },
        entry: {},
        output: {
            path: __dirname,
            filename: 'app/assets/javascripts/[name].js'
        },
        resolve: {
            alias: {
                appVue: path.resolve(__dirname, "./lib/vue"),
                vue: production ? 'vue/dist/vue.min.js' : 'vue/dist/vue.js',

            },
            extensions: ['.js', '.mjs']
        },

        module: {

            rules:[{
                    test: /\.vue$/,
                    loader: 'vue-loader'
                }, {
                    test: /\.css$/,
                    use: [
                        'style-loader',
                        'css-loader'
                    ]
                },{
                    test: /\.scss$/,
                    use: [
                        'style-loader', // creates style nodes from JS strings
                        'css-loader',   // translates CSS into CommonJS
                        {
                            loader: 'sass-loader', // compiles Sass to CSS, using Node Sass by default
                        }
                    ]
                },{
                    test: /\.mjs$/,
                    include: /node_modules/,
                    type: 'javascript/auto'
                }
            ]
        },

        watchOptions: {
            poll: 1000,
            aggregateTimeout: 300,
            ignored: /node_modules/
        },
        plugins: [
            new VueLoaderPlugin()
        ]

    }

    // configuration for OPA
    let filePath = './'+path.join('app', 'vue', 'app.js')
    let fileName = 'maas_app'

    webpackBase.entry[fileName] = filePath

    // configuration for external views, at the moment just login page is needed
    fs.readdirSync(path.join('app', 'vue', 'public')).forEach(controller => {
        if (controller !== 'users_sessions') {
            return
        }

        let filePath = './'+path.join('app', 'vue', 'public', controller, 'app.js')
        let fileName = `${controller.replace('.js')}`

        webpackBase.entry[fileName] = filePath

    })

    webpackConfig.push(webpackBase)

    return webpackConfig
}