# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  sigInst = sigma.init(document.getElementById('sig')).drawingProperties({
    defaultLabelColor: '#000',
    defaultLabelSize: 14,
    defaultLabelBGColor: '#fff',
    defaultLabelHoverColor: '#999',
    labelThreshold: 6,
    defaultEdgeType: 'curve'
  }).graphProperties({
      minNodeSize: 0.5,
      maxNodeSize: 10,
      minEdgeSize: 1,
      maxEdgeSize: 1,
      sideMargin: 50
    }).mouseProperties({
      maxRatio: 32
    })

  sigInst.parseGexf('/friends_graph/gexf');

  sigInst.draw()

  sigInst.startForceAtlas2()

  isRunning = true

  document.getElementById('stop-layout').addEventListener 'click', ->
    if isRunning
      isRunning = false
      sigInst.stopForceAtlas2();
      document.getElementById('stop-layout').childNodes[0].nodeValue = 'Start Layout'
    else
      isRunning = true
      sigInst.startForceAtlas2()
      document.getElementById('stop-layout').childNodes[0].nodeValue = 'Stop Layout'

  document.getElementById('rescale-graph').addEventListener 'click', ->
    sigInst.position(0, 0, 1).draw()