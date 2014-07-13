#!/bin/sh

curl http://localhost:3000/shoes-list/add -d @test2.json --header "accept: application/json"
echo "\n"
