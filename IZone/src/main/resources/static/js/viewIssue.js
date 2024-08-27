$(document).ready(function() {
    // Event listener for 'View Issue' buttons
    $('.view-issue-btn').on('click', function() {
        var issueId = $(this).val(); // Get issueId from button's value attribute

        // Use AJAX to fetch issue details from the server
        $.ajax({
            url: 'issues/' + issueId, // Adjust the URL as needed for your API
            method: 'GET',
            success: function(data) {
                // Populate the modal with issue details
                
                console.log(data)
                $('#issueId').text(data.issueId);
           
                $('#assignee').text(data.assignee);
                $('#reporter').text(data.reporter);
                $('#issueType').text(data.issueType);
                $('#priority').text(data.priority);
                $('#issueStatus').text(data.issueStatus);
                $('#createdDateTime').text(new Date(data.createdDateTime).toLocaleString());
                $('#issueName').text(data.issueName);
                $('#issueSummary').text(data.issueSummary);
                
                // Populate Comments
                /*
                var commentsList = $('#commentsList');
                commentsList.empty();
                data.comments.forEach(function(comment) {
                    commentsList.append('<li>' + comment + '</li>');
                });

                // Populate Attachments
                var attachmentsContainer = $('#attachmentsContainer');
                attachmentsContainer.empty();
                data.documents.forEach(function(document) {
                    attachmentsContainer.append('<div class="p-2"><a href="' + document.url + '" target="_blank">' + document.name + '</a></div>');
                });
				*/
                $('#issueModal').modal('show'); // Show the modal
            },
            error: function(err) {
                console.error('Error fetching issue details:', err);
            }
        });
    });

    // Handle Edit Button Click
    $('#editButton').on('click', function() {
        $('#issueForm input, #issueForm textarea').prop('disabled', false).removeClass('d-md-none');
        $('#issueForm p').addClass('d-md-none');
        $('#editButton').hide();
        $('#saveButton').show();
    });

    // Handle Save Button Click
    $('#saveButton').on('click', function() {
        // Gather updated data from the form
        var updatedIssue = {
            issueId: $('#issueId').text(),
            projectId: $('#projectId').text(),
            assignee: $('#assignee').text(),
            reporter: $('#reporter').text(),
            issueType: $('#issueType').text(),
            priority: $('#priority').text(),
            issueStatus: $('#issueStatus').text(),
            createdDateTime: $('#createdDateTime').text(),
            issueName: $('#issueName').text(),
            issueSummary: $('#issueSummary').text()
            // Add more fields as needed
        };

        // Save the updated details to the server
        $.ajax({
            url: '/issues/' + updatedIssue.issueId,
            method: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(updatedIssue),
            success: function() {
                alert('Issue updated successfully');
                $('#issueForm input, #issueForm textarea').prop('disabled', true).addClass('d-md-none');
                $('#issueForm p').removeClass('d-md-none');
                $('#editButton').show();
                $('#saveButton').hide();
            },
            error: function(err) {
                console.error('Error updating issue:', err);
            }
        });
    });
});
