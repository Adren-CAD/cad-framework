balance = 0

local setBalance = false

function updateBalance()
	SendReactMessage('setBalance', balance)
end

updateBalance()