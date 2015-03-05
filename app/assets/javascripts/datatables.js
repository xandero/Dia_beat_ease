$(document).ready( function () {
    $('#bloodsugar-table').DataTable({
        "lengthMenu": [ 1000, 10, 25, 50, 75, 100 ],
        "bFilter": false,
        "bPaginate": false 
    });
} );