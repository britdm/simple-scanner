package main

import (
	"crypto/tls"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"reflect"
	"time"
)

type ImageTag struct {
	Name string
	Tags []string
}

var (
	url      = "https://localhost:5000/v2"
	username = "admin"
	password = "admin123"
)

func showEntries(repoWithTags string) {
	var entries ImageTag
	json.Unmarshal([]byte(repoWithTags), &entries)

	length := reflect.ValueOf(entries.Tags)
	for i := 0; i < length.Len(); i++ {
		fmt.Printf("%s:%s\n", entries.Name, length.Index(i))
	}
}

func getTags(repos string) {
	var repositories map[string]interface{}
	json.Unmarshal([]byte(repos), &repositories)

	for _, repository := range repositories {
		length := reflect.ValueOf(repository)
		for j := 0; j < length.Len(); j++ {
			req, err := http.NewRequest(
				http.MethodGet, fmt.Sprintf("%s/%s/tags/list", url, length.Index(j)), http.NoBody)
			if err != nil {
				log.Fatal(err)
				fmt.Println(err)
			}
			req.SetBasicAuth(username, password)
			tagResp, err := http.DefaultClient.Do(req)
			if err != nil {
				log.Fatal(err)
			}
			defer tagResp.Body.Close()

			tagRespBody, err := ioutil.ReadAll(tagResp.Body)
			if err != nil {
				log.Fatal(err)
			}
			showEntries(string(tagRespBody))
		}
	}
}

func scanRegistry() {
	client := http.Client{Timeout: 5 * time.Second}
	req, err := http.NewRequest(http.MethodGet, fmt.Sprintf("%s/_catalog", url), http.NoBody)
	if err != nil {
		log.Fatal(err)
	}
	req.SetBasicAuth(username, password)

	resp, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	respBody, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}
	getTags(string(respBody))
}

func main() {
	http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
	scanRegistry()
}
