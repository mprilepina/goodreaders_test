Feature: Verify that author.book API works correctly

	Scenario: Get all books written by Jack London
	
	When Get xml responses from 69 pages with a paginated list of books written by Jack London id 1240
	And Save all information about books to DataBase
	Then Verify that information about 2070 books is stored in DataBase
	And all books are written by Jack London

	When Get response from 70 page
	Then Verify that no books are present
