BlushUiView = require './blush-ui-view'
{CompositeDisposable} = require 'atom'

module.exports = BlushUi =
  blushUiView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @blushUiView = new BlushUiView(state.blushUiViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @blushUiView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'blush-ui:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @blushUiView.destroy()

  serialize: ->
    blushUiViewState: @blushUiView.serialize()

  toggle: ->
    console.log 'BlushUi was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
