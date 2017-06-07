#
#		Helps displaying the pagination controls
#
#		Usage: if any Module Need Pagination then It Needs to copy 3 Directive over here (prev,next,text)
#
#		Note : Dynamic Byinding Will not Work here On runtime So better to copy & Paste Here for New Module
#
class Theeditpagerbuttonprevcurated extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-button-prev.tmpl" pagination-id="curatedListsAll"></div>'
		}

class Theeditpagerbuttonnextcurated extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-button-next.tmpl" pagination-id="curatedListsAll"></div>'
		}

class Theeditpagertextcurated extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-text.tmpl" on-page-change="pageChanged(newPageNumber,curatedListType[3])" pagination-id="curatedListsAll"></div>'
		}

class Theeditpagerbuttonprevmerchandiser extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-button-prev.tmpl" pagination-id="merchandiserListsAll"></div>'
		}

class Theeditpagerbuttonnextmerchandiser extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-button-next.tmpl" pagination-id="merchandiserListsAll"></div>'
		}

class Theeditpagertextmerchandiser extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-text.tmpl" on-page-change="pageChanged(newPageNumber,recommendationListType[3])" pagination-id="merchandiserListsAll"></div>'
		}
class Theeditpagerbuttonprevorders extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-button-prev.tmpl" pagination-id="orders"></div>'
		}

class Theeditpagerbuttonnextorders extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-button-next.tmpl" pagination-id="orders"></div>'
		}

class Theeditpagertextusers extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-text.tmpl" on-page-change="pageChanged(newPageNumber)" pagination-id="users"></div>'
		}
class Theeditpagerbuttonprevusers extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-button-prev.tmpl" pagination-id="users"></div>'
		}

class Theeditpagerbuttonnextusers extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-button-next.tmpl" pagination-id="users"></div>'
		}

class Theeditpagertextorders extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-text.tmpl" on-page-change="pageChanged(newPageNumber)" pagination-id="orders"></div>'
		}

class Theeditpagergoto extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-goto.tmpl"></div>'
		}

class Theeditpagerbuttonprevproduct extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-button-prev.tmpl" pagination-id="products"></div>'
		}

class Theeditpagerbuttonnextproduct extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-button-next.tmpl" pagination-id="products"></div>'
		}

class Theeditpagertextproduct extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls template-url="App/UI/Pager/pager-text.tmpl" on-page-change="pageChanged(newPageNumber,productFilter)" pagination-id="products"></div>'
		}
class Theeditpagerbuttonprevnotification extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-button-prev.tmpl" pagination-id="notificationsLists"></div>'
		}

class Theeditpagerbuttonnextnotification extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-button-next.tmpl" pagination-id="notificationsLists"></div>'
		}

class Theeditpagertextnotification extends Directive
	constructor: ->
		return {
			restrict: 'E'
			template: '<dir-pagination-controls boundary-links="true" template-url="App/UI/Pager/pager-text.tmpl" on-page-change="pageChanged(newPageNumber,notificationListType[3])" pagination-id="notificationsLists"></div>'
		}
