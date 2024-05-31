// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Bookstore {
    struct Book {
        uint id;
        string title;
        string author;
        string publication;
        bool available;
    }

    address public owner;
    uint public nextBookId;
    mapping(uint => Book) public books;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        nextBookId = 1;
    }

    function addBook(string memory title, string memory author, string memory publication) public onlyOwner {
        books[nextBookId] = Book(nextBookId, title, author, publication, true);
        nextBookId++;
    }

    function removeBook(uint id) public onlyOwner {
        require(books[id].id != 0, "Book does not exist");
        books[id].available = false;
    }

    function updateDetails(uint id, string memory title, string memory author, string memory publication, bool available) public onlyOwner {
        require(books[id].id != 0, "Book does not exist");
        books[id] = Book(id, title, author, publication, available);
    }

    function findBookByTitle(string memory title) public view returns (uint[] memory) {
        uint[] memory tempIds = new uint[](nextBookId);
        uint count = 0;

        for (uint i = 1; i < nextBookId; i++) {
            if (keccak256(bytes(books[i].title)) == keccak256(bytes(title))) {
                if (msg.sender == owner || books[i].available) {
                    tempIds[count] = books[i].id;
                    count++;
                }
            }
        }

        uint[] memory result = new uint[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = tempIds[i];
        }
        return result;
    }

    function findAllBooksOfPublication(string memory publication) public view returns (uint[] memory) {
        uint[] memory tempIds = new uint[](nextBookId);
        uint count = 0;

        for (uint i = 1; i < nextBookId; i++) {
            if (keccak256(bytes(books[i].publication)) == keccak256(bytes(publication))) {
                if (msg.sender == owner || books[i].available) {
                    tempIds[count] = books[i].id;
                    count++;
                }
            }
        }

        uint[] memory result = new uint[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = tempIds[i];
        }
        return result;
    }

    function findAllBooksOfAuthor(string memory author) public view returns (uint[] memory) {
        uint[] memory tempIds = new uint[](nextBookId);
        uint count = 0;

        for (uint i = 1; i < nextBookId; i++) {
            if (keccak256(bytes(books[i].author)) == keccak256(bytes(author))) {
                if (msg.sender == owner || books[i].available) {
                    tempIds[count] = books[i].id;
                    count++;
                }
            }
        }

        uint[] memory result = new uint[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = tempIds[i];
        }
        return result;
    }

    function getDetailsById(uint id) public view returns (string memory title, string memory author, string memory publication, bool available) {
        require(books[id].id != 0, "Book does not exist");
        if (msg.sender != owner) {
            require(books[id].available, "Book is not available");
        }
        Book memory book = books[id];
        return (book.title, book.author, book.publication, book.available);
    }
}