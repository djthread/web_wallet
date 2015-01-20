angular.module("app").controller "AdvancedController", ($scope, $state) ->
    console.log "------ AdvancedController ------>"

    # tabs
    $scope.tabs = []
    $scope.tabs.push { heading: "", route: "advanced.preferences", active: true }
    $scope.tabs.push { heading: "", route: "advanced.console", active: false }
    $scope.goto_tab = (route) ->
        $state.go route
    $scope.active_tab = (route) -> $state.is route
    $scope.$on "$stateChangeSuccess", ->
        $scope.tabs.forEach (tab) ->
            tab.active = $scope.active_tab(tab.route)
