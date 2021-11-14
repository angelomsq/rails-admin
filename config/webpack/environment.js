const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
    moment: 'moment/moment'
  })
)

environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
})

// environment.loaders.append("jquery", {
//   test: require.resolve("jquery"),
//   use: [
//     { loader: "expose-loader", options: { exposes: ["$", "jQuery"] } },
//   ],
// })

module.exports = environment