const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const customConfig = require('./custom')
environment.config.merge(customConfig)

environment.plugins.prepend(
    'Provide',
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',

      Popper: ['popper.js', 'default'],
    })
)



module.exports = environment
