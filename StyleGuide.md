# Style Guide

We'll stick to the standard Swift style, which is embodied by the examples in the Swift documentation. So when naming variables, functions, methods, and image assets, use camel-case. Also capitalize the first letter for type names, code files, and folders. And you can use an underscore whenever it's warranted for better clarity. Each type you make should be in its own file, with a matching file name.

For any UIViewController subclasses you make, use a naming convention that follows these examples:

- Root_VC
- Events_VC
- Categories_VC

Instead of:

- RootViewController
- EventsViewController
- CategoriesViewController

The '_VC' is better and more readable, with less boilerplate.

If you're unsure about style, like "where does the space go in this dictionary type [String: String]", or "what's the naming convention of enum cases", just check an example in the Swift documentation.

Swift protocols (which are similar to Java interfaces) have a more advanced naming convention. You can get some ideas from googling 'Swift protocol naming convention', if you end up creating some.
