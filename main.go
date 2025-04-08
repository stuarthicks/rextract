package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"regexp"
)

func main() {

	var exp string
	flag.StringVar(&exp, "e", ".", "A regular expression to match against stdin")

	var grp string
	flag.StringVar(&grp, "g", "", "Extract this named capture group instead of the first capture")
	flag.Parse()

	var p = regexp.MustCompile(exp)

	var s = bufio.NewScanner(os.Stdin)

	for s.Scan() {
		var l = s.Text()
		var m = p.FindStringSubmatch(l)

		if grp == "" {
			if m == nil || len(m) < 2 {
				continue
			}
			fmt.Println(m[1])
			continue
		}

		var i = p.SubexpIndex(grp)
		if i < 0 {
			fmt.Println("error: group '" + grp + "' is not defined in the expression")
			os.Exit(1)
		}

		if len(m)-1 < i {
			// group was not matched in the input, continue to next line
			continue
		}

		fmt.Println(m[i])
	}

}
