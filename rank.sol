// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract StudentResults {
    struct Student {
        uint rollNumber;
        uint marks;
    }

    Student[] public students;
    mapping(uint => bool) private rollNumberExists;

    function insertMarks(uint _rollNumber, uint _marks) public {
        require(!rollNumberExists[_rollNumber], "Roll number already exists");

        students.push(Student(_rollNumber, _marks));
        rollNumberExists[_rollNumber] = true;

        // Sorting students array based on marks in descending order
        for (uint i = students.length - 1; i > 0; i--) {
            if (students[i].marks > students[i - 1].marks) {
                Student memory temp = students[i];
                students[i] = students[i - 1];
                students[i - 1] = temp;
            } else {
                break;
            }
        }
    }

    function scoreByRank(uint rank) public view returns (uint) {
        require(rank > 0 && rank <= students.length, "Invalid rank");
        return students[rank - 1].marks;
    }

    function rollNumberByRank(uint rank) public view returns (uint) {
        require(rank > 0 && rank <= students.length, "Invalid rank");
        return students[rank - 1].rollNumber;
    }

    function topperMarks() public view returns (uint) {
        require(students.length > 0, "No students have been added");
        return students[0].marks;
    }

    function topperRollNumber() public view returns (uint) {
        require(students.length > 0, "No students have been added");
        return students[0].rollNumber;
    }
}