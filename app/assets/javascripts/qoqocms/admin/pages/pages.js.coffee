window.App = {} unless window.App

jQuery ->
  $('.c-pages').each ->
    self = $(this)

    App.order_table = ->
      table = self.find('table')
      table.tableDnD({
        onDrop: (table, tr) ->
          id = $(tr).data('id')
          node_id = $(tr).next().data('id')
          $.post '/admin/pages/'+id+'/order', {
            position: 'left',
            node_id: node_id
          }, (data) ->
            $(table).replaceWith(data)
            App.order_table()
      });

    App.order_table()
