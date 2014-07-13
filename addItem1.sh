#!/bin/sh

curl http://localhost:3000/shoes-list/add -d @test1.json --header "accept: application/json"
echo "\n"
