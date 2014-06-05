README.TXT

Name: The Knight Times by Garo Anguiano-Sainz, Adan Frausto, Colby Seyferth, and Pat Dale

Description: 
Carleton sports news application, that allows users to find relevant articles about current Carleton teams and athletes, available on both IOS and Android. Home page display allows users to view title and glimpse of the description of the most recent articles of all sports. It is possible to select a specific sport to view that teams related articles.  Once an article has been chosen a full screen view of that specific html display will be visible, the user will not be redirected to another site because everything will be in app, except the twitter feed which is still one step away from the home page. The focus of the app was to create a easily accessible way to find relevant articles with a strong focus on a nice UI layout and design. 

What Works, IOS Specific:
	- Home screen with clean UI design, thumbnails when available
	- Easy access to each individual sports team’s articles
	- Available twitter view, only capability that still uses web reference

What Doesn’t Work, IOS Specific: 

Parsing: 
    -Text with NSXMLParser is difficult because we get errors when appending strings after cutting whitespace, even after casting it to a mutable string.
    -The hppl wrapper for libxml2 parser has not yet been fully developed to read xml, so we are unable to get the tags for the story title from hppl parsing either.
    - A bit slower on launch then we could have hoped for. 

Thumbnail images:
    -When adding a thumbnail image to the table, UITableCell does not resize it to a specific dimension. This results in the image taking up a majority of the cell at times, and displaying a warped image.

Features We Would Like To See:
	-A nicer way to display the twitter feed
	- Options/settings to make it a unique to user experience

Getting Started, IOS Specific:
Once the application is running on the emulator or device, you will notice three tabs at the bottom, each of them has a self described purpose. Clicking once on either will take you to their corresponding pages. Clicking once on an item bar on the sports page will take you to a list of articles, and by clicking on either of those articles or article box on the homepage you will be able to the article picked. Returning to sports list from the article view is as easy as hitting the back button on the top left corner. 
