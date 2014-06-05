The Knight Times iOS
	by Garo Anguiano-Sainz and Pat Dale

Description: 
	Carleton sports news application, that allows users to find relevant articles about current Carleton teams and athletes, available on both IOS and Android. Home page display allows users to view title and glimpse of the description of the most recent articles of all sports. It is possible to select a specific sport to view that teams related articles.  Once an article has been chosen a full screen view of that specific html display will be visible, the user will not be redirected to another site because everything will be in app, except the twitter feed which is still one step away from the home page. The focus of the app was to create a easily accessible way to find relevant articles with a strong focus on a nice UI layout and design. 

What Works, IOS Specific:
	- Home screen with clean UI design
	- A story view (no need for a web view!)
	- Tabular view of sport specific articles
	- All information related to each story gets stored to improve load time (the first load will be very slow because no information has been stored yet)
	- Easy access to each individual sports team’s articles
	- Available twitter view, only capability that still uses web reference

What Doesn’t Work, IOS Specific:
	- Parsing the article text works 95% of the time, but occasionally the hpplParser will cut article text short.

Features We Would Like To See:
	-A nicer way to display the twitter feed
	- Options/settings to make it a unique to user experience

Getting Started: 
	IOS Specific: Once the application is running on the emulator or device, you will notice three tabs at the bottom, each of them has a self described purpose. Clicking once on either will take you to their corresponding pages. Clicking once on an item bar on the sports page will take you to a list of articles, and by clicking on either of those articles or article box on the homepage you will be able to the article picked. Returning to sports list from the article view is as easy as hitting the back button on the top left corner. 

Please Note:
	The first load will be very slow because we do not have a server to retrieve the information needed for our app. The phone does all the parsing and scraping, but will store the information related to all stories once that story has been parsed. From then on it will be much faster because all the information will be loaded on startup. Given the opportunity to do this project again, our teams would have definitely decided to build a server and only develop on one platform. This would greatly improve the space used and the speed of our app.
