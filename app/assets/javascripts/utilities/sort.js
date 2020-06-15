$(document).on('turbolinks:load', function () {
  $('.sort-by-title').click(sort_rows);

  function sort_rows() {
    var table = $(this).parents('table').first();
    var column = $(this).attr('data-column');

    var sort_coeff = $(this).find('span.sorter i.fa-sort-alpha-down').length ? -1 : 1;

    table.find('span.sorter').remove();

    $(this).prepend('<span class="sorter float-right"><i class="fa fa-sort-alpha-' + (sort_coeff > 0 ? 'down' : 'up') + '"></i></span>');

    source_rows = table.find('tr').slice(1);

    rows = source_rows.toArray();
    rows.sort(function (row1, row2) {
      text1 = $(row1).find('td:eq(' + column + ')').text().toUpperCase();
      text2 = $(row2).find('td:eq(' + column + ')').text().toUpperCase();
      if (text1 > text2) return sort_coeff;
      if (text1 < text2) return -sort_coeff;
      return 0;
    });

    source_rows.remove()
    table.append(rows);
  }
});
