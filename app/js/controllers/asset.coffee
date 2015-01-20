angular.module("app").controller "AssetController", ($scope, $rootScope, BlockchainAPI, Blockchain, $stateParams, Utils, Wallet) ->
    $scope.feeds=[]
    $scope.symbol2records = Blockchain.symbol2records
    $scope.ticker = $stateParams.ticker.toUpperCase()
    $scope.Utils = Utils
    $scope.issuer =''
    $scope.asset_record = null
    $scope.current_account = $rootScope.current_account
    $scope.asset_name = $scope.ticker
    $scope.trade_market_name = null

    Blockchain.get_asset(0).then (asset) ->
        $scope.asset0 = asset
        $scope.trade_market_name = "#{$scope.ticker}:#{asset.symbol}"

    Blockchain.refresh_asset_records().then ->
        $scope.symbol2records = Blockchain.symbol2records
        console.log($scope.ticker)
        console.log($scope.symbol2records)
        $scope.asset_record = $scope.symbol2records[$scope.ticker]
        if $scope.asset_record and $scope.asset_record.issuer_account_id != -2
            BlockchainAPI.get_account($scope.symbol2records[$scope.ticker].issuer_account_id).then (result) ->
                $scope.issuer = result
        if $scope.asset_record and $scope.asset_record.id > 0
            BlockchainAPI.get_feeds_for_asset($scope.ticker).then (result) ->
                $scope.feeds=result
            if $scope.asset_record.id < 22
                $scope.trade_market_name = "Bit#{$scope.ticker}:#{$scope.asset0.symbol}"