# DUBF
There are characters that looks similar.
For example, upper case 'I' and lower case 'l', upper case 'O' and number '0'.
How they look similar vary depending on fonts or font size.
They can be used to deceive people.
For example:
https://forum.nim-lang.org/t/9164

This program tests you to see whether you can distinguish similar looking characters.
If you fail the test, you should change font or font size so that you can pass the test.

DUBF stands for 'Don't Use Bad Font'.

## Requirements

Nim version 1.6.6

## How to compile and run

```console
$ git clone https://github.com/demotomohiro/DUBF.git
$ cd DUBF
$ nimble run
```

## Sample Screen
```console
Please type following texts as is:
Cat can`t fIy



 >
```

## Future work:
- Implement it as desktop/mobile/web application
But most of them don't allow user to choose font.

- Support unicode
There are many similar looking characters in unicode.
Are there any fonts that supports unicode and dont have any similar looking glyphs? 

# TODO:
- List recommended fonts
