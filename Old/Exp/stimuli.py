# -*- coding: utf-8 -*-
"""
Created on Mon Jun 26 09:34:55 2017

@author: Martin Vasilev
"""

P1= ['While', 'growing', 'up', 'in', 'the', 'countryside,', 'Dan', 'always', 'dreamed', 'of',
	'the', 'vibrant', 'and', 'exciting', 'life', 'in', 'the', 'big', 'city.', 'His', 'dream',
     'eventually', 'came', 'true', 'after', 'he', 'had', 'to', 'move', 'to', 'the', 'capital',
     'to', 'start', 'university.', 'It', 'was', 'only', 'many', 'years', 'later', 'that',
     'he', 'realised', 'that', 'living', 'in', 'such', 'a', 'hectic', 'place', 'had', 'brought',
	'a', 'lot', 'of', 'stress', 'into', 'his', 'life.', 'Once', 'he', 'retired,',
     'Dan', 'moved', 'back', 'to', 'the', 'countryside', 'and', 'rediscovered', 'the', 'peace',
     'and', 'quietude', 'that', 'he', 'remembered', 'from', 'his', 'childhood.']
					
P2= ['In', 'the', 'last', 'several', 'years,', 'there', 'has', 'been', 'a', 'tremendous',
     'increase', 'in', 'the', 'use', 'of', 'renewable', 'sources', 'of', 'energy.',
     'For', 'example,', 'rapid', 'technological', 'advancements', 'and', 'legislation', 'in',
     'some', 'countries', 'have', 'prompted', 'many', 'end', 'users', 'to', 'install',
     'solar', 'panels', 'in', 'their', 'home.', 'Although', 'such', 'panels', 'still', 'have',
     'limited', 'efficiency,', 'they', 'can', 'power', 'such', 'household', 'devices', 'as',
     'washing', 'machines', 'or', 'fridges.', 'As', 'the', 'efficiency', 'with', 'which',
     'they', 'capture', 'energy', 'increases,', 'it', 'is', 'hoped', 'that,', 'one day,',
     'solar', 'panels', 'can', 'power', 'entire', 'buildings.']
					
P3= ['Some', 'of', "Mary's", 'best', 'childhood', 'memories', 'were', 'from', 'visiting',
	'her', "grandparents'", 'farm.', 'They', 'had', 'a', 'big', 'piece', 'of', 'land',
      'that', 'they', 'used', 'for', 'growing', 'a', 'variety', 'of', 'vegetables', 'and',
	'for', 'taking', 'care', 'of', 'the', 'cows.', "Mary's", 'favourite', 'spot', 'was',
	'next', 'to', 'the', 'big', 'cherry', 'tree,', 'where', 'she', 'would', 'play', 'with',
      'her', 'dolls.', 'In', 'the', 'early', 'summer,', 'when', 'the', 'cherry', 'tree', 'was',
      'ripe', 'with', 'fruit,', 'the', 'neighbours', 'would', 'come', 'and', 'help', 'Mary',
	'and', 'her', 'family', 'with', 'the', 'harvest.']
	
P4= ['For', 'much', 'of', 'her', 'career', 'as', 'an', 'accountant,', 'Clara', 'had', 'an', 
     'uneasy', 'relationship', 'with', 'her', 'boss.', 'Even', 'though', 'she', 'put', 'her',
	'heart', 'and', 'soul', 'into', 'her', 'work,', 'he', 'would', 'often', 'criticise', 'the',
	'quality', 'and', 'accuracy', 'of', 'her', 'reports.', 'This', 'working', 'environment',
      'put', 'her', 'in', 'a', 'dilemma,', 'as', 'she', "didn't", 'know', 'whether', 'she',
	'should', 'simply', 'look', 'for', 'a', 'new', 'job', 'or', 'change', 'her', 'career',
	'altogether.', 'Eventually,', 'with', 'the', 'support', 'of', 'friends', 'and', 'family,',
      'Clara', 'decided', 'to', 'try', 'her', 'luck', 'with', 'a', 'new', 'job.']
						
P5= ["John's", 'job', 'at', 'a', 'large', 'national', 'newspaper', 'was', 'a', 'bit',
     'different', 'from', 'what', 'most', 'people', 'imagined', 'he', 'did', 'for', 'a',
     'living.', 'Instead', 'of', 'sitting', 'at', 'a', 'desk', 'and', 'writing', 'articles,',
     'he', 'was', 'sent', 'to', 'different', 'places', 'to', 'photograph', 'and', 'report',
     'the', 'events', 'that', 'happened', 'there.', 'According', 'to', 'John,', 'the', 'job',
     'had', 'its', 'perks,', 'as', 'he', 'would', 'travel', 'all', 'over', 'the', 'world', 
     'for', 'free', 'and,', 'sometimes,', 'also', 'get', 'time', 'off', 'to', 'explore',
     'the', 'area.', 'However,', 'this', 'also', 'came', 'at', 'a', 'price,', 'as', 'he',
     'would', 'occasionally', 'be', 'sent', 'to', 'dangerous', 'areas', 'with', 'ongoing',
	'conflicts.']
	
P6= ['The', 'plan', 'to', 'build', 'an', 'underground', 'system', 'in', 'the',
     'ever-expanding', 'city', 'was', 'met', 'with', 'challenges', 'from', 'the', 'very',
     'beginning.', 'Although', 'the', 'funding', 'for', 'the', 'entire', 'project', 'was',
     'secured,', 'in', 'the', 'beginning', 'there', 'were', 'protests', 'against', 'the',
     'excessive', 'road', 'blocks', 'and', 'the', 'construction', 'noise.', 'Towards', 'the',
     'end', 'of', 'the', 'project,', 'it', 'also', 'became', 'clear', 'that', 'drilling',
     'under', 'the', 'ground', 'in', 'some', 'areas', 'might', 'cause', 'cracks', 'in', 'the',
     'road', 'or', 'even', 'cause', 'damage', 'to', 'historical', 'ruins.', 'For', 'these',
     'reasons,', 'the', 'completion', 'of', 'the', 'underground', 'system', 'was', 
     'postponed', 'until', 'all', 'the', 'technical', 'difficulties', 'could', 'be', 
     'resolved.']


P7= ['During', 'the', 'early', '20th', 'century,', 'the', 'Pacific', 'island', 'was', 'a',
     'natural', 'habitat', 'to', 'a', 'large', 'number', 'of', 'tropical', 'birds,', 'some',
     'of', 'which', 'were', 'unique', 'to', 'the', 'island.', 'However,', 'a', 'few',
     'snakes', 'that', 'were', 'accidentally', 'let', 'loose', 'on', 'the', 'island',
     'greatly', 'reduced', 'their', 'number.', 'Because', 'the', 'snakes', 'did', 'not',
     'have', 'any', 'natural', 'predators', 'on', 'the', 'island,', 'their', 'population',
     'increased', 'without', 'control.', 'Although', 'different', 'measures', 'were', 'tried',
     'to', 'contain', 'the', 'problem,', 'many', 'of', 'the', 'bird', 'species', 'had',
     'become', 'extinct', 'by', 'the', 'end', 'of', 'the', 'century.']

P8= ['Shortly', 'after', 'Jane', 'moved', 'to', 'the', 'city', 'by', 'the', 'sea,', 'she',
     'started', 'a', 'new', 'hobby', 'of', 'collecting', 'sea', 'pebbles', 'and', 'shells,',
     'gluing', 'them', 'together', 'to', 'make', 'paintings.', 'Initially,', 'she', 'would',
     'give', 'her', 'creations', 'to', 'friends', 'as', 'a', 'gift,', 'but,', 'soon,',
     'they', 'became', 'so', 'popular', 'that', 'she', 'considered', 'making', 'a', 'living',
     'out', 'of', 'her', 'hobby.', 'Jane', 'struggled', 'to', 'find', 'a', 'steady', 'supply',
     'of', 'customers', 'when', 'she', 'first', 'started,', 'but,', 'eventually,',
     'somebody', 'suggested', 'that', 'she', 'sell', 'her', 'work', 'online.', 'This',
     'helped', 'her', 'build', 'a', 'successful', 'business', 'and', 'she', 'even', 'got',
     'invited', 'to', 'do', 'her', 'own', 'art', 'exhibition', 'at', 'a', 'local', 'gallery.']
					
					
P9= ['The', 'jeweller', 'carefully', 'examined', 'the', 'elegant', 'butterfly', 'brooch',
     'that', 'had', 'a', 'small', 'ruby', 'stone', 'in', 'the', 'middle.', 'Although', 'the',
     'brooch', 'looked', 'expensive,', 'the', 'jeweller', 'noticed', 'that', 'it', 'only',
     'had', 'silver', 'plating', 'and', 'that', 'the', 'stone', 'was', 'just', 'a', 'cheap',
     'imitation.', 'In', 'his', 'experience,', 'such', 'cheap', 'jewelleries', 'were', 
     'frequently', 'sold', 'on', 'the', 'Internet', 'and', 'were', 'marketed', 'to', 
     'gullible', 'buyers', 'for', 'a', 'higher', 'price', 'than', 'what', 'they', 'were',
     'actually', 'worth.', 'To', 'avoid', 'such', 'purchases,', 'the', 'jeweller', 'often',
     'advised', 'his', 'clients', 'to', 'shop', 'from', 'established', 'merchants', 
     'only', 'and', 'to', 'look', 'at', 'the', 'materials', 'that', 'were', 'used', 'to',
     'make', 'the', 'item.']					
					
P10= ['The', 'non-profit', 'organisation', 'aimed', 'to', 'help', 'people', 'from',
	'developing', 'countries', 'by', 'supplying', 'them', 'with', 'bicycles.', 'Because',
      'of', 'the', 'lack', 'of', 'infrastructure,', 'having', 'a', 'bike', 'can', 'enable',
	'people', 'to', 'easily', 'travel', 'to', 'work,', 'access', 'healthcare', 'in',
      'nearby', 'towns,', 'or', 'even', 'carry', 'water', 'from', 'distant', 'places.',
	'Thanks', 'to', 'their', 'original', 'idea,', 'the', 'organisation', 'was', 'able',
      'to', 'secure', 'funding', 'for', 'the', 'next', 'year,', 'but', 'they', 'are',
	'still', 'looking', 'for', 'major', 'sponsors.', 'If', 'no', 'such', 'sponsors',
      'are', 'found,', 'another', 'plan', 'is', 'to', 'raise', 'money', 'from', 'regular',
	'donations', 'or', 'to', 'host', 'charity', 'events.']	


P11= ['Many', 'tourists', 'visiting', 'the', 'land-locked', 'country', 'were', 'not',
	'aware', 'of', 'the', 'pristine', 'lake', 'that', 'was', 'situated', 'near', 'its',
      'eastern', 'border.', 'Because', 'it', 'was', 'surrounded', 'by', 'a', 'forest', 
	'and', 'there', 'were', 'no', 'major', 'roads', 'going', 'there,', 'the', 'lake',
	'was', 'mostly', 'known', 'only', 'by', 'the', 'locals.', 'However,', 'with', 'its',
      'crystal-clear', 'waters', 'and', 'unforgettable', 'scenery,', 'the', 'unspoiled',
	'lake', 'was', 'a', 'dream', 'place', 'to', 'relax.', 'According', 'to', 'one', 
	'local', 'legend,', 'the', "lake's", 'water', 'had', 'rejuvenating', 'powers', 'and',
      'many', 'people', 'from', 'the', 'region', 'would', 'go', 'there', 'in', 'the', 
	'summer', 'for', 'a', 'swim.']

P12= ['In', 'the', 'previous', 'century,', 'some', 'countries', 'in', 'the', 'Northern',
	'hemisphere', 'were', 'major', 'producers', 'of', 'paper,', 'which', 'resulted', 'in',
      'the', 'deforestation', 'of', 'whole', 'areas.', 'However,', 'nowadays,', 'there',
	'is', 'a', 'pressing', 'need', 'to', 'reverse', 'the', 'damage', 'in', 'order', 'to',
	'reduce', 'carbon', 'dioxide', 'levels', 'and', 'to', 'preserve', 'wildlife.',
	'One', 'measure', 'that', 'has', 'been', 'taken', 'is', 'to', 'plant', 'trees',
      'in', 'the', 'most', 'affected', 'areas', 'in', 'order', 'to', 'restore', 'the',
	'forests.', 'Although', 'not', 'suitable', 'for', 'full-time', 'employment,',
      'such', 'jobs', 'can', 'be', 'a', 'decent', 'source', 'of', 'income', 'for',
	'students', 'or', 'seasonal', 'workers', 'who', 'want', 'to', 'spend', 'the',
	'summer', 'working', 'among', 'nature.']
	
P13= ['The', 'small', 'community', 'of', 'fishers', 'were', 'making', 'a', 'living', 'by',
	'going', 'into', 'the', 'sea', 'on', 'most', 'days', 'of', 'the', 'year', 'and',
      'casting', 'their', 'nets.', 'Despite', 'the', 'uncertainty', 'of', 'what', 'they',
	'would', 'catch,', 'this', 'was', 'the', 'only', 'profession', 'that', 'they', 'knew',
	'and,', 'for', 'many', 'of', 'them,', 'this', 'was', 'also', 'the', 'job', 'that',
	'their', 'parents', 'once', 'did.', 'However,', 'in', 'recent', 'years,', 'the',
      "fishers'", 'livelihood', 'was', 'endangered', 'because', 'commercial', 'companies',
	'were', 'overfishing', 'the', 'area', 'and,', 'on', 'top', 'of', 'this,', 'the', 
	'fish', 'populations', 'had', 'further', 'decreased', 'due', 'to', 'oil', 'spills.',
      'Therefore,', 'to', 'protect', 'their', 'income,', 'the', 'government', 'needed', 
	'to', 'implement', 'tougher', 'regulations', 'on', 'sea', 'fishing', 'and',
	'transportation.']	

P14= ['The', 'vast', 'Arctic', 'has', 'long', 'been', 'an', 'area', 'that', 'has', 'not',
	'been', 'thoroughly', 'investigated', 'due', 'to', 'its', 'harsh', 'weather', 'and',
	'icy', 'conditions.', 'However,', 'in', 'recent', 'years,', 'scientists', 'have',
	'made', 'use', 'of', 'this', 'unique', 'place', 'to', 'answer', 'questions', 'about',
	'the', 'adaptability', 'of', 'life', 'and', 'the', "Earth's", 'geological', 'past.',
	'By', 'drilling', 'hundreds', 'of', 'metres', 'into', 'the', 'ice,', 'researchers',
	'have', 'been', 'able', 'to', 'study', 'how', 'microorganisms', 'adapt', 'to', 'such',
	'conditions', 'in', 'order', 'to', 'survive.', 'Also,', 'the', 'ice', 'samples',
	'obtained', 'can', 'reveal', 'what', 'the', "Earth's", 'climate', 'was', 'like',
	'thousands', 'of', 'years', 'ago,', 'when', 'the', 'ice', 'was', 'first', 'formed.']

P15= ['Johan', 'was', 'an', 'avid', 'traveller', 'who', 'would', 'often', 'use', 'his',
	'holidays', 'or', 'breaks', 'from', 'work', 'to', 'visit', 'new', 'places', 'and',
	'document', 'his', 'experiences', 'on', 'camera.', 'However,', 'unlike', 'most',
	'people,', 'he', 'preferred', 'to', 'travel', 'off', 'the', 'beaten', 'track,',
	'often', 'hiking', 'through', 'deep', 'forests', 'or', 'riding', 'on', 'the', 
	'backroads', 'with', 'his', 'bike.', 'For', 'him,', 'this', 'was', 'the', 'only',
	'way', 'that', 'one', 'could', 'experience', 'the', 'beauty', 'of', 'nature',
	'and', 'get', 'to', 'know', 'the', 'local', 'people.', 'He', 'would', 'often',
	'share', 'his', 'travelling', 'videos', 'online', 'in', 'an', 'attempt', 'to',
	'inspire', 'others', 'and', 'to', 'show', 'what', 'makes', 'travelling',
      'so', 'interesting.']
						
P16= ['The', 'vast', 'boreal', 'forest', 'offers', 'thrill', 'seekers', 'the', 'unique',
	'opportunity', 'to', 'explore', 'a', 'region', 'that', 'is', 'barely', 'populated',
	'by', 'humans,', 'but', 'yet', 'one', 'that', 'is', 'teeming', 'with', 'wildlife.',
	'The', 'breath-taking', 'scenery', 'and', 'the', 'beauty', 'of', 'this', 'remote',
	'area', 'are', 'favoured', 'by', 'many', 'hikers,', 'who', 'usually', 'follow',
	'established', 'hiking', 'trails.', 'However,', 'this', 'promise', 'of', 'adventure',
	'also', 'has', 'some', 'hidden', 'risks,', 'such', 'as', 'the', 'lack', 'of', 'clean',
	'water', 'and', 'potential', 'encounters', 'with', 'bears.', 'Therefore,', 'as',
	'there', 'are', 'few', 'and', 'sparsely-situated', 'service', 'stations,', 'one',
	'needs', 'to', 'be', 'well-prepared', 'for', 'their', 'journey.']

P17= ['The', 'news', 'that', 'a', 'wealthy', 'family', 'had', 'bought', 'a', 'large', 
	'piece', 'of', 'land', 'in', 'the', 'centre', 'spread', 'quickly', 'through', 'the',
	'small', 'town.', 'It', 'was', 'thought', 'that', 'the', 'family', 'had', 'acquired',
	'the', 'land', 'in', 'order', 'to', 'build', 'a', 'big', 'mansion', 'that', 'they',
	'would', 'use', 'during', 'the', 'summer', 'months.', 'Although', 'there', 'was', 'a',
	'lot', 'of', 'speculation', 'about', 'the', 'buyers,', 'not', 'much', 'was', 'known',
	'about', 'them', 'or', 'how', 'they', 'could', 'afford', 'to', 'make', 'such', 'a',
	'big', 'investment.', 'The', 'family', 'appeared', 'to', 'have', 'become', 'rich',
	'overnight', 'by', 'investing', 'money', 'into', 'new', 'telecommunication', 
	'technology.']

P18= ['Producing', 'honey', 'has', 'long', 'been', 'a', 'traditional', 'craft', 'that',
	'people', 'from', 'certain', 'regions', 'have', 'exercised', 'for', 'centuries.',
	'However,', 'in', 'recent', 'years,', 'many', 'local', 'producers', 'are', 'faced',
	'with', 'difficulties', 'because', 'it', 'has', 'become', 'more', 'expensive', 'and',
	'less', 'efficient', 'to', 'produce', 'honey.', 'The', 'reason', 'for', 'this', 'is',
	'that', 'bee', 'populations', 'have', 'been', 'greatly', 'reduced', 'by', 'the', 
	'heavy', 'use', 'of', 'pesticides', 'in', 'agriculture,', 'which', 'has', 'also',
	'decreased', 'profitability.', 'In', 'addition,', 'the', 'possibility', 'of', 
	'chemicals', 'entering', 'the', 'production', 'process', 'has', 'made', 'it', 'more',
	'challenging', 'to', 'create', 'an', 'organic', 'product.']

P19= ['After', 'lengthy', 'planning,', 'the', 'city', 'council', 'announced', 'that', 'a',
	'new', 'annual', 'festival', 'was', 'to', 'start', 'in', 'the', 'summer.', 'The',
	'festival', 'would', 'be', 'situated', 'at', 'the', 'outskirts', 'of', 'the', 'city',
	'and', 'would', 'include', 'a', 'wide', 'range', 'of', 'food', 'products', 'on',
	'display,',  'as', 'well', 'as', 'many', 'family', 'events.', 'The', 'purpose', 'of',
	'this', 'festival', 'was', 'to', 'promote', 'the', 'local', "farmers'", 'products', 
	'and', 'to', 'foster', 'the', 'development', 'of', 'the', 'region.', 'It', 'was',
	'expected', 'that', 'the', 'new', 'festival', 'would', 'attract', 'many', 'tourists,',
	'who', 'would', 'also', 'contribute', 'to', 'the', 'economy', 'and', 'local', 
	'businesses', 'in', 'the', 'city.']

P20= ['The', 'archaeologists', 'were', 'excited', 'to', 'uncover', 'the', 'remains', 'of',
      'an', 'ancient', 'village', 'buried', 'in', 'close', 'proximity', 'to', 'the', 'river.',
	'The', 'site', 'was', 'found', 'after', 'using', 'combined', 'evidence', 'from',
	'old', 'historical', 'records', 'and', 'modern', 'geological', 'mapping', 'technology.',
	'The', 'archaeologists', 'suspected', 'that', 'the', 'village', 'was', 'at', 'least',
	'a', 'few', 'thousand', 'years', 'old,', 'as', 'the', 'infrastructure', 'and',
	'building', 'materials', 'were', 'not', 'typical', 'for', 'more', 'recent', 'times.',
	'One', 'particular', 'mystery', 'about', 'the', 'place', 'was', 'how', 'the', 
	'residents', 'had', 'maintained', 'their', 'food', 'supply,', 'given', 'that', 'there',
	'was', 'no', 'evidence', 'of', 'farming', 'or', 'keeping', 'livestock.']

P21= ['The', 'start-up', 'conference', 'was', 'an', 'annual', 'event', 'that', 'came',
	'about', 'after', 'a', 'group', 'of', 'young', 'developers', 'decided', 'to', 'create',
	'a', 'platform', 'to', 'help', 'people', 'start', 'their', 'own', 'business.',
	'This', 'soon', 'grew', 'into', 'its', 'own', 'event,', 'as', 'many', 'people', 'were',
	'interested', 'in', 'exchanging', 'knowledge', 'and', 'experience', 'in', 'this', 
	'area.', 'The', 'conference', 'was', 'usually', 'run', 'by', 'volunteers', 'and',
	'included', 'talks', 'given', 'by', 'people', 'with', 'lengthy', 'experience', 'in',
	'start-ups,', 'as', 'well', 'as', 'experts', 'from', 'economics', 'and', 'business.',
	'Despite', 'its', 'low-key nature,', 'the', 'conference', 'had', 'already', 'led',
	'to', 'some', 'good', 'ideas', 'that', 'were', 'turned', 'into', 'promising',
	'businesses.']
	
P22= ['The', 'mountain', 'range', 'contained', 'a', 'large', 'system', 'of', 'caves', 
      'that', 'covered', 'an', 'enormous', 'area', 'and', 'were', 'often', 'many', 'miles',
      'deep.', 'Although', 'known', 'for', 'many', 'centuries,', 'the', 'caves', 'were',
	'largely', 'unexplored', 'due', 'to', 'their', 'expansive', 'nature', 'and', 'the',
	'danger', 'of', 'falling', 'rocks.', 'Because', 'some', 'of', 'the', 'rock',
	'sediments', 'were', 'not', 'particularly', 'strong,', 'it', 'was', 'not', 'uncommon',
	'for', 'the', 'ceiling', 'to', 'collapse', 'in', 'some', 'sections.', 'Indeed,',
	'after', 'one', 'earthquake', 'caused', 'parts', 'of', 'the', 'system', 'to', 'be',
	'closed,', 'visits', 'to', 'the', 'caves', 'were', 'restricted', 'and', 'could', 'be',
	'accomplished', 'only', 'if', 'accompanied', 'by', 'trained', 'personnel.']	

P23= ['The', 'rapid', 'urban', 'growth', 'had', 'created', 'a', 'number', 'of', 'problems',
	'for', 'its', 'residents,', 'but', 'the', 'increasing', 'air', 'pollution', 'was',
	'the', 'most', 'apparent', 'one.', 'Due', 'to', 'the', 'bad', 'quality', 'of', 'the',
	'air,', 'the', 'city', 'was', 'often', 'engulfed', 'in', 'smog', 'and', 'many', 
	'pulmonary', 'diseases', 'were', 'on', 'the', 'rise.', 'Healthcare', 'workers', 'had',
	'long', 'urged', 'officials', 'to', 'take', 'measures,', 'but', 'this', 'was', 'often',
	'to', 'no', 'avail.', 'Some', 'options', 'to', 'combat', 'this', 'were', 'to',
	'encourage', 'people', 'to', 'use', 'public', 'transport', 'more', 'and', 'to', 'ban',
      'cars', 'from', 'central', 'areas,', 'although', 'it', 'was', 'still', 'not', 'known',
	'if', 'these', 'would', 'be', 'implemented.']

P24= ['The', 'production', 'of', 'palm', 'oil', 'has', 'long', 'played', 'a', 'major',
      'role', 'in', 'the', 'industry', 'of', 'some', 'tropical', 'countries.', 'Because',
      'it', 'can', 'be', 'used', 'for', 'preparing', 'a', 'wide', 'range', 'of', 'food',
      'products', 'and', 'also', 'as', 'a', 'biofuel,', 'the', 'demand', 'for', 'palm',
      'oil', 'plantations', 'has', 'increased', 'over', 'the', 'years.', 'However,',
	'this', 'has', 'come', 'at', 'a', 'cost,', 'as', 'the', 'production', 'has', 'led',
	'to', 'a', 'number', 'of', 'environmental', 'problems,', 'such', 'as', 'severe',
	'deforestation', 'and', 'the', 'endangerment', 'of', 'species.', 'In', 'addition,',
	'the', 'use', 'of', 'palm', 'oil', 'in', 'biofuels', 'may', 'further', 'increase',
	'the', 'amount', 'of', 'greenhouse', 'emissions.']
	
P25= ['According', 'to', 'the', 'police', 'report,', 'the', 'fugitives', 'were', 'spotted',\
      'a', 'few', 'miles', 'south', 'of', 'the', 'river.', 'They', 'were', 'reported', 'by',\
	'an', 'elderly', 'couple', 'who', 'saw', 'them', 'sneaking', 'into', 'a', 'cabin', \
	'looking', 'for', 'food.', 'After', 'this', 'last', 'sighting,', 'the', 'police',\
      'lost', 'track', 'of', 'their', 'whereabouts,', 'although', 'they', 'believe', 'that',\
	'the', 'fugitives', 'are', 'still', 'in', 'the', 'region.', 'There', 'was', 'some',\
	'anecdotal', 'evidence', 'of', 'people', 'seeing', 'them,', 'but', 'it', 'could', 'never',
	'be', 'confirmed', 'that', 'it', 'was', 'actually', 'them.']

P26= ['The', 'small', 'coastal', 'town', 'is', 'best', 'known', 'for', 'the', 'medieval', 'castle',\
      'that', 'is', 'situated', 'on', 'a', 'steep', 'hill', 'to', 'the', 'south.', 'Although', 'now',\
	'in', 'ruins,', 'the', 'castle', 'has', 'a', 'long', 'and', 'bloody', 'history,', 'and',\
	'played', 'a', 'central', 'role', 'in', 'some', 'of', 'the', 'events', 'that', 'shaped', 'the',\
	'history', 'of', 'the', 'region.', 'According', 'to', 'one', 'early', 'theory,', 'the',\
	'castle', 'was', 'destroyed', 'by', 'a', 'flood,', 'but', 'this', 'was', 'later', 'shown',\
	'to', 'be', 'incorrect.', 'Today,', 'historians', 'agree', 'that', 'the', 'castle', 'met',\
	'its', 'fate', 'in', 'the', '18th', 'century', 'when', 'it', 'was', 'badly', 'damaged', 'by',\
	'cannon', 'fire', 'during', 'an', 'enemy', 'occupation.']	
	
P27= ['Just', 'like', 'every', 'Saturday', 'morning,', 'Anna', 'put', 'on', 'her', 'fleece',
	'jacket', 'and', 'went', 'out', 'to', 'do', 'her', 'park', 'run.', 'As', 'Anna', 'was',\
	'about', 'to', 'head', 'home,', 'she', 'was', 'surprised', 'to', 'meet', 'her', 'friend,',\
	'Karen,', 'whom', 'she', 'had', 'not', 'seen', 'since', 'they', 'graduated', 'from', 'high',\
	'school.', 'The', 'two', 'women', 'went', 'to', 'a', 'nearby', 'cafe', 'and', 'chatted',\
	'about', 'their', 'university', 'life', 'and', 'career', 'aspirations.', 'Anna', 'was', \
	'surprised', 'to', 'learn', 'that', 'her', 'friend', 'had', 'tied', 'the', 'knot', 'just',\
	'a', 'few', 'months', 'earlier', 'and', 'was', 'about', 'to', 'go', 'on', 'honeymoon', 'after',\
	'the', 'end', 'of', 'the', 'semester.']
	
P28= ['Jake', 'had', 'long', 'been', 'looking', 'forward', 'to', 'his', 'summer', 'holiday,',\
      'during', 'which', 'he', 'planned', 'to', 'travel', 'around', 'Europe', 'by', 'car,',\
      'visiting', 'different', 'towns', 'and', 'historical', 'places', 'on', 'the', 'Mediterranean',\
	'Sea.', 'However,', 'his', 'initial', 'plan', 'changed', 'after', 'his', "car's", 'engine',\
	'died,', 'leaving', 'him', 'with', 'no', 'easy', 'way', 'to', 'continue', 'his', 'journey.',\
	'Instead', 'of', 'returning', 'home,', 'Jake', 'decided', 'to', 'hitchhike', 'the',\
	'remaining', 'distance', 'and,', 'as', 'such,', 'he', 'still', 'managed', 'to', 'visit', 'many',
	'of', 'the', 'original', 'places', 'that', 'he', 'wanted', 'to', 'see.', 'By', 'travelling',\
	'with', 'other', 'people,', 'Jake', 'also', 'managed', 'to', 'experience', 'the', 'local',\
	'culture', 'and', 'learn', 'more', 'about', 'how', 'people', 'in', 'these', 'countries',
	'lived.']


P= [P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18,
				P19, P20, P21, P22, P23, P24, P25, P26, P27, P28]

# Questions:
QE1= ['Did Dan start university in the capital?',
      'Has the use of renewable energy increased in recent years?',
      "Did Mary's grandparents have a farm?",
      'Did Clara decide to sue her boss?',
	'Did John photograph events around the world?',
	'Were there challenges to building the underground system?',
	'Did wild cats cause the ecological problem?',
	'Did Jane use sea shells and pebbles to make paintings?',
	'Did the jeweller examine a pair of earrings?',
	'Did the organisation supply people with computers?', # 10
	'Were many tourists aware of the lake?',
	'Did the production of paper result in the deforestation of some regions?',
	'Did the fishers cast their nets in the sea?',
	'Has everything in the Arctic been thoroughly investigated?',
	'Did Johan prefer to travel on paved roads?',
	'Is the boreal forest densely populated by humans?',
	'Did the wealthy family buy land in the town?',
	'It is cheaper to produce honey today?',
	'Did the council announce a new tax programme?',
	'Was the village close to the ocean?',
	'Was the conference about starting your own business?',
	'Were the caves mostly unexplored?',
	'Was there smog in the city?',
	'Has the production of palm oil decreased?',
	'Did the elderly couple see them rob a supermarket?',
	'Was the town known for its medieval castle?',
	'Did Anna do yoga on Saturdays?',
	"Did Jake's car engine die on the road?"
	]
						
QE2= ['Did Dan continue living in the capital after he retired?',
      'Were there any examples about using biomass energy in the text?',
      'Was there a cherry tree on the property?',
      'Did Clara have an easy relationship with her boss?',
	'Did John write articles in an office?',
	'Were there technical difficulties?',
	'Did many bird species go extinct in the end?',
	'Did Jane get invited to do an art exhibition?',
	'Were cheap jewelleries often sold on the internet?',
	'Was the organisation looking for sponsors?', # 10
	'Did the lake have unforgettable scenery?',
	'Is planting trees a full-time employment?',
	"Was the fishers' livelihood secure?",
	"Do scientists study rock samples from the Arctic?",
	'Did Johan try to inspire others with his videos?',
	'Does one need to prepare well for a journey in the boreal forest?',
	'Did the family invest into agriculture?',
	'Is it more challenging now to create organic honey?',
	'Was the event expected to contribute to local businesses?',
	'Was there evidence of farming in the village?',
	'Was the conference run by private corporations?',
	'Did flooding cause some parts of the caves to be closed?',
	'Were there any examples about the danger to farm animals?',
	'Has palm oil production led to deforestation?',
	'Did the police lose track of where the fugitives were?',
	'Was the castle damaged by an earthquake?',
	'Did Anna and her friend go to a casino?',
	"Did Jake travel the remaining distance by plane?"
	]

AQE1= [1, 1, 1, 2, 1, 1, 2, 1, 2, 2, # 10
	 2, 1, 1, 2, 2, 2, 1, 2, 2, 2	, #20
	 1, 1, 1, 2, 2, 1, 2, 1]
		
AQE2= [2, 2, 1, 2, 2, 1, 1, 1, 1, 1, # 10
	 1, 2, 2, 2, 1, 1, 2, 1, 1, 2, #20
	 2, 2, 2	, 1, 1, 2, 2, 2]


QD1= ["What was Dan's dream as a child?",
	"What factors were mentioned that influence people's decision to buy solar panels?",
	"What is true about Mary's grandparents?",
	"What was the criticism of Clara's boss?",
	"What did John do for a living?",
	"What was one of the challenges when the construction first started?",
	"What was the problem on the island?",
	"Which of the following statements about Jane's hobby is FALSE?",
	"What did the examination of the jewellery reveal?",
	"What is one potential application of the organisation's help?",
	"Why was the lake not known by many tourists?",
	"What problem did the massive paper industry cause?",
	"What is true about the fishers?",
	"Why has the Arctic not been better investigated?",
	"What is TRUE about Johan's travels?",
	"What can be said about the boreal forest?",
	"What is TRUE about the purchased land?",
	"What are some differences of producing honey today compared to the past?",
	"Which of the following facts about the event is FALSE?",
	"What is known about the discovery of the village?",
	"How did the conference first start?",
	"Which of the following facts about the caves is TRUE?",
	"What is TRUE about air pollution in the area?",
	"Why is the production of palm oil important?",
	"What is true about the fugitives?",
	"Which of the following statements about the castle is correct?",
	"Which of the following things happened on that Saturday morning?",
	"What can be said about Jake's plan for his holiday?"]
	
QD2= ['What is TRUE about Dan’s later life?',
	'What can be concluded about solar panels from the text?',
	'What is FALSE about the cherry tree?',
	"What was Clara's dilemma?",
	"What is TRUE about John's job?",
	"What happened during the last stages of the project?",
	"What is TRUE about birds on the island?",
	"What happened after Jane started her business?",
	"What was the jeweller's advice for purchasing items?",
	"Which of the following funding strategies was NOT considered?",
	"What can be said about the water in the lake?",
	"What can a person planting trees expect?",
	"Why is it more difficult for the fishers to make a living these days?",
	"What is something that has been recently investigated in the Arctic?",
	"What was Johan's attitude towards making traveling films?",
	"What is one potential danger of hiking in the boreal forest?",
	"What can be said about the buyers?",
	"What are some recent challenges to the production process?",
	"What is one purpose of the event?",
	"What is TRUE about the village?",
	"What was typical for the conference?",
	"What is known about the structure of the caves?",
	"What has been suggested as a potential solution to the problem?",
	"Which of the following is NOT a consequence of palm oil production?",
	"What is the latest information about the fugitives?",
	"What happened to the castle?",
	"What is something that Anna and her friend did NOT talk about?",
	"What happened during Jake's holiday?"]


QD1opts= [["1) To study for a degree in a big institution",
           "2) To study for a degree in a big metropolitan area",
           "3) To experience working in an industrial area",
           "4) To experience living in a lively urban area"],
           ["1) The development of applied science and local regulations",
            "2) The lack of clear laws and the need to pay taxes",
            "3) The efficiency of solar panels and their ability to power kitchen equipment",
            "4) The falling prices and the possibility to power big buildings"],
	    ["1) They used their farm land only to care for the animals",
           "2) They cultivated flowers and produced honey",
           "3) They cultivated plants but did not have any animals",
           "4) They cultivated plants and also had animals"],
	    ["1) That she is not putting enough effort into her work",
	     "2) That her work is not good enough",
	     "3) That her output does not look very professional",
	     "4) That she cannot work very well with others"],
	    ["1) He provided illustration materials for newsworthy stories",
	     "2) He wrote news stories from his office",
	     "3) He was paid to travel and blog about his experiences",
	     "4) He was paid to write a book about dangerous conflicts"],
	    ["1) People complained about the big budget",
	     "2) People complained because of the traffic disruptions",
           "3) People complained because of the significant environmental impact",
           "4) People were concerned about the potential damage to public buildings"],
	    ["1) Bird populations were endangered by a lack of resources",
	     "2) Bird populations were affected by human hunting",
	     "3) Bird populations were affected by human activity",
	     "4) Birds could not adapt to the tropical conditions"],
	    ["1) Her artwork made for good presents",
	     "2) Her artwork became a reality only after she relocated",
	     "3) Her artwork featured drawings of objects from the sea",
	     "4) Her artwork had the potential to enhance her income"],
	    ["1) That it was made from silver, but the gemstone was not authentic",
	     "2) That it was not made from silver, but the gemstone was polished",
	     "3) That it was not made from silver and the gemstone was not polished", 
	     "4) That it was not made from silver and the gemstone was not authentic"],
	    ["1) Supporting tourism by making it easier to travel",
	     "2) Allowing people to sell their products in adjacent areas",
	     "3) Making it easier to stay employed",
	     "4) Reducing the cost of daily products" ],
          ["1) It was situated at the edge of the country",
           "2) It was in the middle of the woods",
	     "3) It was situated in a natural reserve",
	     "4) It was dangerous to swim in it"],
          ["1) It resulted in an excess of paper in the Northern hemisphere",
           "2) It created many temporary and underpaid jobs",
           "3) It reduced the number of hikers visiting the forest",
           "4) It threatened the existence of animals living in the forest"],
          ["1) They went fishing only during the summer",
	     "2) Usually, their profession ran in the family",
	     "3) They would inevitably come home with a good catch",
	     "4) Many of them had alternative career options"],
	    ["1) Because it is isolated and difficult to reach",
	     "2) Because of the limited life forms living there",
           "3) Because of its frosty climate",
           "4) Because there is nothing that cannot be found elsewhere"],
	    ["1) He was not employed and could make trips whenever he wanted",
	     "2) He avoided going through wooded areas",
           "3) He was not keen on making the details of his trips public", 
           "4) He would avoid the main routes whenever he could"],
	    ["1) It is a land with rich fauna",
           "2) It is a land with limited flora",
           "3) It is a land with significant human presence",
           "4) It is a land that is inaccessible to backpackers"],
	    ["1) It was intended for building a permanent residence",
           "2) It was intended for building a residence that would be rented to wealthy people",
           "3) It was intended for building a recreational residence",
           "4) It was intended for building a telecommunication factory"],
          ["1) The production process requires bigger financial investments",
           "2) The production process requires better equipment",
           "3) The production process takes less time than it did before",
           "4) The production process requires less human supervision"],
	    ["1) It will be related to cuisine and cooking",
	     "2) It will be in the vicinity of the city",
	     "3) It will be held in the middle of the year",
           "4) It will be a one-off event"],
          ["1) It was discovered after finding evidence of old farming activity",
           "2) It was discovered in a place with no supply of water",
           "3) It was discovered with the help of research",
           "4) It was discovered by accident" ],
          ["1) It was established by a professional society",
           "2) It evolved from an informal group",
           "3) A group of individuals wanted to generate income from the conference",
           "4) People wanted to use it to find potential investors"],
          ["1) They were discovered only recently",
           "2) They are predominantly uncharted",
           "3) They have been in use for many centuries",
	     "4) They are fairly safe for visitors"],
          ["1) It was the only issue affecting its citizens",
           "2) The extent of the issue had not gotten any worse over time",
           "3) It has led to health-related issues",
	     "4) It has led to complaints from the local residents"],
          ["1) It has many potential applications",
           "2) It is superior to other types of oil",
           "3) It is rarer to find these days",
           "4) It costs less compared to other types of oil" ],
          ["1) They were seen swimming in the river",
           "2) They were spotted by the police",
           "3) They tried to find something to eat"
	     "4) They threatened an old couple"],
	    ["1) Only few people knew about it",
	     "2) In the past, there was a lot of violence associated with it",
	     "3) The castle is still in a good shape even after many centuries",
	     "4) It was not relevant to any of the affairs that happened in the area"],
	    ["1) Anna went to the park with Karen",
	     "2) Anna spontaneously invited Karen to join her in the park",
	     "3) Anna did her regular morning activity",
	     "4) Anna did her regular morning activity with Karen"],
	    ["1) It didn't work due to unexpected problems",
	     "2) He had to abandon it due to unexpected problems",
           "3) He had to change it a bit due to unexpected problems",
           "4) It all went smoothly without any unexpected problems"]]

#  
#  
#  
#  
QD2opts= [["1) He wanted to revisit places from his childhood",
           "2) He lost his job but he found a more tranquil life",
           "3) He led a tranquil life after he no longer had to work",
	       "4) He quit his job to be at peace again"],
	    ["1) They can be used to power entire houses",
           "2) They can be used to power certain equipment at home",
           "3) They can power small residential houses, but not large ones",
	     "4) They can power buildings because they are already efficient enough"],
	    ["1) Mary's family received assistance with picking the fruit",
           "2) The tree was a place where Mary liked spend her time",
           "3) Mary loved to have fun with her friends next to the tree",
           "4) The cherries were ready for picking after the spring season ended"],
	    ["1) Whether to leave her position or to make a complaint against her boss",
           "2) Whether to find new employment or to talk with her boss",
           "3) Whether to stay at her current place of work or to find a new one",
           "4) Whether to find employment elsewhere or to change her professional path"],
	    ["1) He didn't have to pay the expenses for his business trips",
           "2) His job didn't involve taking any risks",
           "3) He couldn't go sightseeing in the places that he visits for work",
           "4) He could work from his office if he didn't want to go on a business trip"],
	    ["1) Construction works continued despite some unexpected problems",
           "2) Construction works were abandoned due to the damage to buildings",
           "3) Construction works were put on hold because of some unexpected problems",
	     "4) Construction works were stopped after the project went over budget"],
	    ["1) The total bird count decreased, but all breeds survived",
           "2) The total bird count decreased and many breeds did not survive",
           "3) The count of some breeds decreased, while the count of others did not",
           "4) The total bird count decreased and a few breeds did not survive"],
	    ["1) Her business did well in the beginning",
           "2) Her business did not do well in the beginning but improved later on",
           "3) Her business did well in the beginning and further improved later on",
           "4) Her business did not do well initially but benefited from an investment"],
	    ["1) To avoid sales from unverified sellers",
	     "2) Not to buy jewelleries online",
           "3) To compare the prices with other sellers",
           "4) To ask experts like him before buying an item"],
	    ["1) Asking volunteers to make periodic contributions",
           "2) Appealing to the government for support",
           "3) Looking for people or organisations willing to donate large sums of money",
           "4) Creating fundraiser shows"],
	    ["1) It was murky and shallow",
	     "2) It was believed to make you feel younger and more energetic",
	     "3) It was believed to alleviate stress and chronic medical conditions",
	     "4) It was thought to be suitable for drinking"],
	    ["1) A long-term, annual contract",
	     "2) Reasonable compensation for their labour",
           "3) A job for the autumn months",
           "4) All the amenities of city life"],
	    ["1) The government has restricted how much fishing they can do",
           "2) They have to sell at a cheaper price to compete with big businesses",
           "3) Big businesses have reduced the number of fish in the sea",
           "4) They have to pay more money to transport their catch"],
	    ["1) How the snow cover changes with the climate",
           "2) Frozen water that was deposited millennia ago",
           "3) How the Earth's climate supports life",
           "4) Animals that adapted to find food under thin ice"],
          ["1) He wanted to take beautiful shots of forests",
           "2) He wanted to highlight the aspects of the journey that are fascinating",
           "3) He uploaded his videos because he aspired to be an online celebrity",
           "4) He was trying to promote beautiful natural reserves that are not well-known"],
          ["1) Not finding enough food",
           "2) Not having brought warm clothes",
           "3) Venturing off the secure paths",
           "4) Drinking from contaminated sources"],
          ["1) They had accumulated their wealth over a long time",
           "2) They had staked capital into a branch that gave them a quick profit",
           "3) They were established people from the region",
           "4) They were known to acquire such assets and use them to grow their business"],
          ["1) The lands have been overtaken by farmers",
           "2) There are fewer insects to create the output",
           "3) There are fewer people buying the product, which reduces the profit",
           "4) Few producers can afford to use chemicals to improve their product"],
          ["1) To encourage people to visit and explore the area",
           "2) To encourage farmers to produce better quality products",
           "3) To encourage local people to spend more time out in the summer",
           "4) To encourage farmers to increase the range of products that they offer"],
          ["1) It was built in the last millennium",
           "2) The building components were typical for the 15th century",
           "3) The village had supported the ability to grow plants for food",
           "4) It did not appear that the villagers had had domestic animals"],
          ["1) Presenters were usually new to the area",
           "2) Professionals from the industry usually did not present",
           "3) Many presenters were people who had founded their own firm",
           "4) Many presenters were established academics"],
          ["1) It is made from rocks that are uncommon in this region",
           "2) It is not durable enough to keep the caves intact",
	     "3) It is strong and prevents any sections from caving in",
           "4) It prevents the use of navigation tools"],
          ["1) Asking people from medical professions for their advice",
           "2) Making residents more aware of the issue",
           "3) Promoting urban transit services",
           "4) Increasing taxes for cars"],
          ["1) Animals are brought to extinction",
           "2) The soil is contaminated with pesticides",
           "3) Air pollution is exacerbated",
           "4) Trees are cut down to make way for plantations"],
	    ["1) It is thought that they are still hiding somewhere in the area",
	     "2) There is reliable evidence that they are still in the area",
	     "3) They were chased by the police, but they managed to escape",
	     "4) It is thought that they may have fled the country"],
	    ["1) The enemy burned it to the ground",
	     "2) The enemy demolished it with heavy artillery",
	     "3) It was destroyed by an enormous amount of water",
	     "4) Historians are not sure how it was destroyed"],
	    ["1) What they want to do for a living",
	     "2) Exercise and healthy diet",
	     "3) What experiences they had had while studying for a higher degree",
	     "4) Their personal relationships"],
	    ["1) He mostly saw areas that were not part of his original plan",
	     "2) He shared a ride with others",
           "3) He went to a museum to experience the local culture",
           "4) He contemplated living in one of the countries"]]
											

AQD1=[4,1,4,2,1,2,3,3,4,3, #10
      2,4,2,3,4,1,3,1,4,3, #20
	2,2,3,1,3,2,3,3]
AQD2=[3,2,3,4,1,3,2,2,1,2, #10
      2,2,3,2,2,4,2,2,1,4, #20
	3,2,3,2,1,2,2,2]


#def genDesign(trials, ncond, start, QE1, QE2, AQE1, AQE2):
#		
#	ID= range(1, len(trials)+1)
#	
#	cond_t= range(start, ncond+1)
#	if start>1:
#		cond_t= cond_t + range(1, start)
#	cond= cond_t*5
#	
#	# shuffle elements:
#	c= list(zip(ID, trials, cond, QE1, QE2, AQE1, AQE2))
#	from random import shuffle
#	shuffle(c)
#	ID, trials, cond, QE1, QE2, AQE1, AQE2 = zip(*c)
#	
#	return(ID, trials, cond, QE1, QE2, AQE1, AQE2)
						



#print(genDesign(1))