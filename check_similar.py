import difflib
print difflib.SequenceMatcher(
        None, "1 2 3 4", "12 3 4").ratio()
