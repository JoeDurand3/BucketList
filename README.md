#Introduction
Welcome to BucketList, a convenient mobile app that will keep track of your
life's ambitions and desires in one convenient place. While you can use this
same project to make any kind of list, the point of this project is to demonstrate
delegation and working with data within the Apple development ecosystem.

In this project, we'll look at the oh-so-powerful [UITableView](), more practice
with Auto Layout, and simple data usage.

#About Delegates
A Delegate is defined as *a person sent or authorized to represent others*, and
this definition isn't too far away from what a delegate in iOS does. As discussed
briefly in HelloDeveloper, a view by itself is unintelligent (can't get its
own information) and needs to rely on something to give it information to display.

In this case, we will be working with UITableViews, so we will need to designate
a UITableViewDelegate and UITableViewDataSource (a data delegate) for the table
to get its information from. We will assign these to be the view controller
that contains it.

#Tour
We will stick with the one view (saved in a storyboard) and one view controller
design we implemented in the first project.

###`Main.storyboard`
Notice now that 'Main.storyboard' has some new bells and whistles; we have a
`UINavigationController`](https://developer.apple.com/reference/uikit/uinavigationcontroller) that contains our main screen. This `UINavigationController` only gives us the space to place our
UIBarButtonItems to delete and add items to our bucket list. If you inspect it
with the Connections Editor, you will notice that our main view is the
*root view controller*, meaning it is first (and in this case only) view it
contains. While `UINavigationController` is very powerful indeed, this is where
we say goodbye for now.

Similarly to the HelloDeveloper, we have several subviews in our main view that
we will use to control and access our app's information, namely *deleteItemButton*,
*addItemButton*, (both `UIBarButtonItems`) and *bucketTable* (a `UITableView`).

###`BucketListViewController`
`BucketListViewController` is a subclass of `UIViewController` that will allow
us to connect our data to our view, just as last time, but in a slightly different
way. Note that 'BucketListViewController' implement the `UITableViewDelegate`
and `UITableViewDataSource` protocols (aka interfaces) - more on this in a moment.

Lets look at each function and what happens inside:

###`var bucketList: [BucketListItem] = []`
We have a single variable that will contain our data for this app. It is an array
of BucketListItem (check out the class), and it starts out empty.

###`viewDidLoad()`
We are assigning the target and action of both buttons so that they know what to
do when they are activated. Their target will be the object it is controlling,
in this case the `BucketListViewController` (`self`). Their action will be the
function to fire then they are tapped, addItem and deleteItem for *addItemButton*
and *deleteItemButton* respectively. This is a form of delegation; we are letting
these buttons delegate their behavior to something else.

Notice that we also have the *bucketTable* delegating its functionality to the
`BucketListViewController`. However, something as complicated as a `UITableView`
needs more instruction that the buttons did. The table by itself has NO idea how
many rows it should have, and what should go in each row? Re-introducing the
`UITableViewDelegate` and `UITableViewDataSource` protocols mentioned earlier.
Implementing these protocols means that this `BucketListViewController` can tell the *bucketTable* what it needs to know by including functions that provide this data. Let's look at the two most basic
functions we need to make this thing work:

###`AddItem()`
To add an item to the bucket list, we make use of a [`UIAlertController`](https://developer.apple.com/reference/uikit/uialertcontroller).
We give the user a text box to input their item, and give them the add and cancel
options. As this can get complicated, check out my comments in the file to understand
what is happening line by line.

### `func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell`:
Wow, is that a mouth full. This looks complicated, but lets simply read what it
says: *tableView... cell for row at index path... and it returns a `UITableViewCell`.*
You might have guessed it; this function will return the cell for the given
index path (AKA location) in the table. Matching up our array of bucket list with
the index keeps this simple; the first item in our array goes in the first row,
so on and so on. We will create a cell, label it with the corresponding item in
our bucket list, and return it to the table for use.

###`func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int`:
Lets read this one like we did the previous one: *tableView... number of rows in
section... and it returns an integer.* This is what will tell the `UITableView`
how many rows it should generate. Keep in mind that if this number is greater than
what the previous function can provide, you're app will crash!


I encourage you to go beneath these functions, type in "func tableView" and arrow
up/down through the various tableView functions you can implement. Check out the
descriptions that accompany them. There are lots of methods that can be used to
make your `UITableViews` more powerful and faster to load.


#Resources
`UITableView` is an extremely useful and powerful tool in any developer's toolbox.
Read Apple's documentation on it here: https://developer.apple.com/reference/uikit/uitableview

Learn more about `UIAlertController`: https://developer.apple.com/reference/uikit/uialertcontroller
