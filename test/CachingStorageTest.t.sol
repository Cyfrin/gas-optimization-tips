// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/13-caching-storage/CacheStorage.sol";
import "../src/13-caching-storage/ReadStorage.sol";

contract GasComparisonTest is Test {
    CacheStorage cacheStorage;
    ReadStorage readStorage;
    uint256 constant NUM_ITERATIONS = 100;
    uint256[] public inputNumbers = [10,20,30,40,50];

    function setUp() public {
        cacheStorage = new CacheStorage();
        readStorage = new ReadStorage();

        cacheStorage.addNumbers(inputNumbers);
        readStorage.addNumbers(inputNumbers);
    }

    function testCacheStorage() public returns (uint256) {

        uint256 totalGasUsedCachingStorage = 0;

        for (uint256 i = 0; i < NUM_ITERATIONS; i++) {
            uint256 gasBefore = gasleft();
            cacheStorage.sumNumbers();
            totalGasUsedCachingStorage += (gasBefore - gasleft());
        }

        uint256 averageGasUsedCachingStorage = totalGasUsedCachingStorage / NUM_ITERATIONS;
        emit log_named_uint(
            "Average Gas Used for caching",
            averageGasUsedCachingStorage
        );
        return averageGasUsedCachingStorage;
    }

    function testReadStorage() public returns (uint256) {

        uint256 totalGasUsedReadingStorage = 0;

        for (uint256 i = 0; i < NUM_ITERATIONS; i++) {
            uint256 gasBefore = gasleft();
            readStorage.sumNumbers();
            totalGasUsedReadingStorage += (gasBefore - gasleft());
        }

        uint256 averageGasUsedReadingStorage = totalGasUsedReadingStorage / NUM_ITERATIONS;
        emit log_named_uint(
            "Average Gas Used for caching",
            averageGasUsedReadingStorage
        );
        return averageGasUsedReadingStorage;
    }

    function testEfficiencyComparisonCashing() public {
        uint256 avgGasUsedReadingStorage = testReadStorage();
        uint256 avgGasUseCachingStorage = testCacheStorage();

        if (avgGasUsedReadingStorage >= avgGasUseCachingStorage) {
            uint256 saving = ((avgGasUsedReadingStorage - avgGasUseCachingStorage) * 100) /
                avgGasUsedReadingStorage;
            console.log("Gas savings by caching: ", saving, "%");
        } else {
            console.log(
                "Unexpected result: reading from storage used less gas than caching"
            );
        }
    }
}
