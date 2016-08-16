var app2 = window.app = {};
app2.Subjects = function() {
  this._input = $('#subjects2-search-txt');
  this._initAutocomplete();
};

app2.Subjects.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/system/search',
        appendTo: '#subjects2-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },


  _render: function(ul, item) {
    var markup = [
      '<span class="division">' + item.division + ' ' + '</span>',
      '<span class="name">' + item.name + ' '  + ' </span>',
      '<span class="prof">' + item.prof + ' 교수님' + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.name + '-' + ui.item.prof);
    
    return false;
  }
};