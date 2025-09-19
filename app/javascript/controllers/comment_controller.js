// app/javascript/controllers/comments_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleReply(event) {
    event.preventDefault()
    const commentBlock = event.currentTarget.closest(".comment-block")
    const replyForm = commentBlock.querySelector(".reply-form")
    if (!replyForm) return

    replyForm.style.display = replyForm.style.display === "block" ? "none" : "block"
    event.currentTarget.textContent = replyForm.style.display === "block" ? "Hide" : "Reply"
  }

  toggleReplies(event) {
    event.preventDefault()
    const commentBlock = event.currentTarget.closest(".comment-block")
    const repliesSection = commentBlock.querySelector(".replies-section")
    if (!repliesSection) return

    repliesSection.style.display = repliesSection.style.display === "block" ? "none" : "block"
    event.currentTarget.textContent = repliesSection.style.display === "block" ? "Hide Replies" : "View All"
  }
}
