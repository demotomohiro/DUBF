import std/[tables, random, strutils, strformat, sugar, terminal]

const
  LooksSameChars = [{'I', 'l', '1', '|'},
                    {'O', '0'},
                    {',', '.'},
                    {'`', '\''},
                    {';', ':'}]

  TestTexts = ["I don't know",
               "Don't be evil",
               "On linux",
               "1 - 1 = 0",
               "On|Off",
               "0.1 + 0.2 = 0.3",
               "('1', '2', '0')",
               "|-x| = x",
               "Cat can't fly",
               "x1 = 0;",
               "He said: 'Hello'",
               "Opengl",
               "Open `fd`",
               "echo `date`",
               "` key opens console",
               "y = 0 ? 1.0 : 2.0",
               "rmdir c:\\"]

  CharMap = block:
    var charMap: Table[char, set[char]]
    for charSet in LooksSameChars:
      assert charSet.card > 1
      for j in charSet:
        charMap[j] = charSet

    charMap

  NumTests = 8

func charInfo(c: char): string =
  if isAlphaAscii(c):
    "Alphabet '" & toUpperAscii(c) & '\''
  elif isDigit(c):
    "Digit '" & c & '\''
  else:
    "Punctuation mark " & c

proc main =
  var rand = initRand()

  var
    numCorrect, numSimpleTypo = 0
    numLooksSameCharMistake = initCountTable[array[2, char]]()

  for i in 1 .. NumTests:
    var text = rand.sample(TestTexts)
    block:
      var changeChars: set[char]
      for c in text:
        if c in CharMap:
          incl changeChars, c
      for c in changeChars:
        let r = rand.sample(CharMap[c])
        text = text.replace(c, r)

    stdout.eraseScreen
    echo "Please type following texts as is:"
    echo text
    stdout.write "\n\n\n > "
    let userInput = stdin.readLine
    if text == userInput:
      inc numCorrect
    else:
      if text.len != userInput.len:
        inc numSimpleTypo
      else:
        for j in 0 ..< text.len:
          if text[j] != userInput[j]:
            let val = CharMap.getOrDefault(text[j])
            if userInput[j] in val:
              inc numLooksSameCharMistake,
                  [min(text[j], userInput[j]),
                   max(text[j], userInput[j])]
            else:
              inc numSimpleTypo

  if numCorrect == NumTests:
    echo "You have typed all texts correctly!"
  else:
    dump numCorrect
    dump numSimpleTypo
    if numLooksSameCharMistake.len != 0:
      echo "It seems following characters looks same for you."
      for k, v in numLooksSameCharMistake:
        echo &"{k[0]}{k[1]}:"
        echo &"  {charInfo(k[0])}, {charInfo(k[1])}"
        echo &"  Decimal Ascii code: {k[0].int}, {k[1].int}"

main()
