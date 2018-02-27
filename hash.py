import hashlib
import sys

if __name__ == "__main__":
  m = hashlib.md5()
  for i in range(3, len(sys.argv)):
    with open(sys.argv[i], "rb") as fh:
      m.update(fh.read())
  h = m.hexdigest()[:5]
  with open(sys.argv[2], "w") as out:
    with open(sys.argv[1], "r") as inp:
      out.write(inp.read().replace("@HASH@", h))
