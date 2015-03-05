$(document).ready( function () {
    $('#bloodsugar-table').DataTable({
        "lengthMenu": [ 10, 25, 50, 75, 100 ],
         "ajax": "data.json"
        // "paging": true
        // "pageLength": 50
    });
} );