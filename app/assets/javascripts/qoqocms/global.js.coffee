jQuery ->
  mainNav = $('#navigation').children('ul')

  mainNav.on 'mouseenter', 'li', ->
    self = $(this)
    subMenu = self.children('ul')
    self.addClass('hover') if( subMenu.length )
    subMenu.hide().stop(true, true).slideDown('fast')
  .on 'mouseleave', 'li', ->
    $(this).removeClass('hover').children('ul').stop(true, true).slideUp('fast')
