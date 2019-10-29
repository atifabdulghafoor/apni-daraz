const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugin.append('Provide', new webpack.Provide({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'] 
}))

module.exports = environment
