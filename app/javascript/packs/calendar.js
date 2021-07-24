const commonCalendarOptions = {
  views: {
    timeGridOneDay: {
      type: 'timeGrid',
      duration: { days: 1 },
      buttonText: 'nap',
      slotLabelFormat: {
        hour: 'numeric',
        minute: '2-digit',
        meridiem: false
      },
      nowIndicator: true
    }
  },
  eventTimeFormat: {
    hour: 'numeric',
    minute: '2-digit',
    meridiem: false
  },
  buttonText: {
    today: 'ma',
    month: 'hónap',
    week: 'hét',
  },
  nowIndicator: true,
  locale: 'hu',
  selectable: true,
  eventColor: '#426145', //primary
  eventBorderColor: '#2f5e4e', //secondary
  eventClick: (calEvent) =>
    (location.href = `/events/${calEvent.event.id}`)
}

function calendarWebView(data, calendarEl) {
  const calendar = new FullCalendar.Calendar(calendarEl, {
    ...commonCalendarOptions,
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'timeGridOneDay,timeGridWeek,dayGridMonth',
    },
    initialView: 'dayGridMonth',
    events: data,
    select: (info) => {
      if (info.view.type === 'dayGridMonth') {
        calendar.gotoDate(info.start)
        calendar.changeView('timeGridOneDay')
      } else {
        location.href = `/events/${info.id}`
      }
    }
  })
  return calendar
}

function calendarMobileView(data, calendarEl) {
  const calendar = new FullCalendar.Calendar(calendarEl, {
    ...commonCalendarOptions,
    headerToolbar: {
      left: 'title',
      center: '',
      right: 'timeGridOneDay,timeGridWeek,dayGridMonth'
    },
    initialView: 'timeGridWeek',
    footerToolbar: {
      center: 'prev,today,next'
    },
    titleFormat: {
      year: 'numeric',
      month: 'short',
      weekday: 'short',
      day: 'numeric'
    },
    aspectRatio: 0.75,
    events: data,
    select: (info) => {
      if (info.view.type === 'dayGridMonth') {
        calendar.gotoDate(info.start)
        calendar.changeView('timeGridOneDay')
      }
      else {
        location.href = `/events/${info.id}`
      }
    }
  })
  return calendar
}

document.addEventListener('DOMContentLoaded', () => {
  var calendarEl = document.getElementById('calendar')

  fetch(`/events.json`)
    .then(response => response.json())
    .then(data => {
      if (window.innerWidth < 768) {
        calendarMobileView(data, calendarEl).render()
      }
      else {
        calendarWebView(data, calendarEl).render()
      }
    })
})
