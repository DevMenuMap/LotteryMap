module MetaTagsHelper
	def meta_title(store)
		if params[:controller] == 'stores' && params[:action] == 'show'
			store_meta_title(store)	
		else
			basic_meta_title
		end
	end

	def meta_description(store)
		if params[:controller] == 'stores' && params[:action] == 'show'
			store_meta_description(store)	
		else
			basic_meta_description
		end	
	end

	def basic_meta_title
		'LotteryMap || 로또(lotto), 연금복권, 스피또 당첨점 검색 서비스'
	end

	def basic_meta_description
		'LotteryMap에서는 로또(Lotto), 연금복권, 스피또500, 스피또1000, 스피또2000 등 국내 모든 복권의 1등, 2등 당첨 결과와 당첨금액, 당첨번호를 확인하실 수 있습니다. 또한 각 지역 로또 당첨 판매점, 연금복권 당첨 판매점을 확인해보세요.'
	end

	def store_meta_title(store)
		title = store.name + ' - '
		title += store.rank.lottery.name(false) + ' '
		title += store.rank.round_in_ko + '차 '
		title += store.rank.rank_in_ko + ' 당첨 판매점'
		title += '(' + store.short_addr + ')'
	end

	def store_meta_description(store)
		rank = store.rank
		lottery = rank.lottery

		desc = store.name + '은 '
		desc += rank.round_in_ko + '차 '
		desc += lottery.name(false) + ' '
		desc += rank.rank_in_ko + ' 당첨자를 배출해낸 행운의 '
		desc += lottery.name + '명당입니다. '
		desc += rank.rank_in_ko + ' 당첨금액: '
		desc += rank.winning_in_won
		if lottery.date_exists?
			desc += ', 추첨일: ' + lottery.date_in_ko
		end
		desc += ', 판매점 주소: '
		desc += store.addr
	end
end
