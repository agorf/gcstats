if (!GCStats) {
    Array.prototype.max = function () {
        return Math.max.apply(Math, this);
    };

    Array.prototype.min = function () {
        return Math.min.apply(Math, this);
    };

    var GCStats = {
        highlight_table: function (table) {
            var finds, finds_max;

            finds = $(table).find('td.finds');

            finds_max = finds.map(function () {
                return $(this).text() * 1;
            }).get().max();

            finds.filter(function () {
                return $(this).text() * 1 === finds_max;
            }).each(function () {
                $(this).parent().find('td').addClass('hl b');
            });
        },
        highlight_square_table: function (table) {
            var total_row, row_max, total_col, col_max, inner_cells, table_max;

            // total row

            total_row = $(table).find('tr.total td');

            row_max = total_row.slice(0, -1).map(function () {
                return $(this).text() * 1;
            }).get().max();

            total_row.addClass('hl').filter(function () {
                return $(this).text() * 1 === row_max;
            }).addClass('b');

            total_row.last().addClass('b');

            // total column

            total_col = $(table).find('td.total');

            col_max = total_col.map(function () {
                return $(this).text() * 1;
            }).get().max();

            total_col.addClass('hl').filter(function () {
                return $(this).text() * 1 === col_max;
            }).addClass('b');

            // inner cells

            inner_cells = $(table).find('td:not(.hl)');

            table_max = inner_cells.filter(function () {
                return ($(this).text() * 1).toString() === $(this).text();
            }).map(function () {
                return $(this).text() * 1;
            }).get().max();

            inner_cells.filter(function () {
                return $(this).text() * 1 === table_max;
            }).addClass('hl b');
        },
    };

    $(document).ready(function () {
        $('table.highlight:not(.square)').each(function () {
          GCStats.highlight_table(this);
        });

        $('table.highlight.square').each(function () {
          GCStats.highlight_square_table(this);
        });
    });
}
