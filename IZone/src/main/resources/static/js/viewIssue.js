$(document).ready(function() {
    // Event listener for 'View Issue' buttons
    $('.view-issue-btn').on('click', function() {
    var issueId = $(this).val(); // Get issueId from button's value attribute


    // Search functionality backlog page
    $("#issueSearch").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#issuesTable tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });

    
    // Use AJAX to fetch issue details from the server
    $.ajax({
        url: 'issues/' + issueId, // Adjust the URL as needed for your API
        method: 'GET',
        success: function(data) {
            // Populate the modal with issue details
            console.log(data);
            $('#issueId').val(data.issueId); // Use .val() for input fields
            $('#assignee').val(data.assignee);
            $('#reporter').val(data.reporter);
            $('#issueType').val(data.issueType);
            $('#priority').val(data.priority);
            $('#issueStatus').val(data.issueStatus);
            
            // Convert date 
            var dateTimeArray = data.createdDateTime;
            var date = new Date(dateTimeArray[0], dateTimeArray[1] - 1, dateTimeArray[2]);

            // Format date as YYYY-MM-DD
            var formattedDate = date.toISOString().split('T')[0];
            
            $('#createdDateTime').val(formattedDate); // Use .val() for input fields
            
            $('#issueName').val(data.issueName);
            $('#issueSummary').val(data.issueSummary);
            
            // Populate Comments
            var commentsList = $('#commentsList');
            commentsList.empty();
            data.comments.forEach(function(comment) {
                var dateTimeArray = comment.createdDateTime;
                var date = new Date(dateTimeArray[0], dateTimeArray[1] - 1, dateTimeArray[2]);

                // Format date as YYYY-MM-DD
                var formattedDate = date.toISOString().split('T')[0];
                commentsList.append('<li>' + comment.content + ' - <small>' + comment.submitter + ' on ' + formattedDate + '</small></li>');
            });
            
            // Populate Attachments
            var attachmentsContainer = $('#attachmentsContainer');
            attachmentsContainer.empty();
            data.documents.forEach(function(doc) {
                var link = $('<a></a>') // Create a new <a> element with jQuery
                    .attr('href', `/downloader?filePath=${encodeURIComponent(doc.documentPath)}`)
                    .attr('download', doc.documentName)
                    .addClass('btn btn-primary btn-sm m-2')
                    .text(`${doc.documentName}`);
                attachmentsContainer.append(link); // Append the <a> element to the container
            });
            
            $('#issueModal').modal('show'); // Show the modal
        },
        error: function(err) {
            console.error('Error fetching issue details:', err);
        }
	    });
	});

	$('#saveButton').on('click', function() {
	    // Gather form data
	    var formData = {
	        issueName: $('#issueName').val(),
	        issueId: $('#issueId').val(),
	        issueType: $('#issueType').val(),
	        assignee: $('#assignee').val(),
	        issueStatus: $('#issueStatus').val(),
	        priority: $('#priority').val(),
	        issueSummary: $('#issueSummary').val()
	    };
	
	    // Send data to server
	    $.ajax({
	        url: 'updateIssue/' + formData.issueId, // Adjust the URL as needed for your API
	        method: 'POST', // Use PUT to update the existing resource
	        contentType: 'application/json',
	        data: JSON.stringify(formData),
	        success: function(response) {
	            // Handle success
	            console.log('Issue updated successfully:', response);
	            // Refresh page
			    window.location.href = '/board';
			            
	            
	            // Optionally, you can refresh or update the issue details displayed
	            // For example, you might need to re-fetch the data or update UI elements
	        },
	        error: function(err) {
	            console.error('Error updating issue:', err);
	        }
	    });
	});

    
    var initialValues = {};

	// Function to populate and store initial values
	function storeInitialValues() {
	    initialValues = {
	        issueName: $('#issueName').val(),
	        issueType: $('#issueType').val(),
	        assignee: $('#assignee').val(), 
	        issueStatus: $('#issueStatus').val(),
	        priority: $('#priority').val(),
	        issueSummary: $('#issueSummary').val(),
	    };
	}
	
	$('#editButton').on('click', function() {
		// store initial values 
		storeInitialValues();
		
	    // Enable form fields for editing
	    $('#issueName, #issueType, #assignee, #issueStatus, #priority, #issueSummary').removeAttr('disabled');
	    
	    // Show Save and Cancel buttons
	    $('#saveButton').show();
	    $('#cancelButton').show();
	    $('#editButton').hide();
	});
	
	$('#cancelButton').on('click', function() {
	    // Restore initial values
	    $('#issueName').val(initialValues.issueName).prop('disabled', true);
	    $('#issueType').val(initialValues.issueType).prop('disabled', true);
	    $('#assignee').val(initialValues.assignee).prop('disabled', true);
	    $('#issueStatus').val(initialValues.issueStatus).prop('disabled', true);
	    $('#priority').val(initialValues.priority).prop('disabled', true);
	    $('#issueSummary').val(initialValues.issueSummary).prop('disabled', true);
    
	    // Toggle button visibility
	    $('#editButton').show();
	    $('#saveButton').hide();
	    $('#cancelButton').hide();
	});
	
	$('#closeButton').on('click', function() {

	    // Disable form fields
	    $('#issueName, #issueType, #assignee, #issueStatus, #priority, #issueSummary').attr('disabled', 'disabled');
	    
	    // Toggle button visibility
	    $('#editButton').show();
	    $('#saveButton').hide();
	    $('#cancelButton').hide();
	});
	
	// Event listener for the comment form submission
    $('#submitComment').on('click', function() {
	    var commentText = $('#commentText').val(); // Get the comment text
	    var issueId = $('#issueId').val(); // Get the current issueId from the modal
	
	    if (commentText.trim() !== "") {
	        $.ajax({
	            url: '/saveComment/' + issueId,
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ content: commentText }),
	            success: function(data) {
	                alert('Comment added successfully');
	                $('#commentText').val(''); // Clear the comment textarea
	                loadIssueDetails(issueId); // Reload the issue details to show the new comment
	            },
	            error: function(err) {
	                console.error('Error adding comment:', err);
	                alert('Failed to add comment.');
	            }
	        });
	    } else {
	        alert('Comment cannot be empty.');
	    }
	});
  
    
    //Handle save attachment
    $('#submitAttachment').click(function() {
		var formData = new FormData();
		var file = $('#attachmentFile')[0].files[0];
		var issueId = $('#issueId').val();
		if (issueId) {
            formData.append('issueId', issueId);  // Add the issueId to the FormData
        }
		
		if(file) {
            formData.append('attachments', file);  // Add the file to the FormData

            $.ajax({
                url: '/saveIssueAttachments',  // Your POST route for saving attachments
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert('File uploaded successfully.');
                    loadIssueDetails(issueId);
                },
                error: function(error) {
                    alert('Failed to upload file.');
                }
            });
        } else {
            alert('Please select a file to upload.');
        }
		
	})
    
    
    // Function to load issue details including comments
    function loadIssueDetails(issueId) {
        $.ajax({
            url: 'issues/' + issueId, // Adjust the URL as needed for your API
            method: 'GET',
            success: function(data) {
                // Populate the modal with issue details (assume this part is done as in your previous code)

                // Populate Comments
                var commentsList = $('#commentsList');
                commentsList.empty();
                data.comments.forEach(function(comment) {
					var dateTimeArray = comment.createdDateTime;
					var date = new Date(dateTimeArray[0], dateTimeArray[1] - 1, dateTimeArray[2]);
				
					// Format date as YYYY-MM-DD
					var formattedDate = date.toISOString().split('T')[0];
                    commentsList.append('<li>' + comment.content + ' - <small>' + comment.submitter + ' on ' +  formattedDate + '</small></li>');
                });				

                $('#issueModal').modal('show'); // Show the modal
            },
            error: function(err) {
                console.error('Error fetching issue details:', err);
            }
        });
    }
});
